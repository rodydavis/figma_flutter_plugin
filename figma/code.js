/// <reference path="../third_party/figma/index.d.ts" />

figma.showUI(__html__, { width: 350, height: 700 });

figma.ui.onmessage = async (msg) => {
  const type = msg.msg_type;
  let { id } = msg;
  callback(msg, "init", () => {
    return {
      msg_type: type,
      editorType: figma.editorType,
      command: figma.command,
      id,
    };
  });
  callback(msg, "function", async () => {
    const { name, args, attrs, keys } = msg;
    let method = figma;
    const parts = name.split(".");
    for (const part of parts) {
      method = method[part];
    }
    const result = await method(...(args || []));
    if (attrs) {
      for (const key in attrs) {
        const value = attrs[key];
        if (key in result || result.hasOwnProperty(key)) {
          result[key] = value;
        } else if (result["set" + key]) {
          result["set" + key](value);
        } else if (Object(result)[key]) {
          Object(result)[key] = value;
        }
      }
    }
    if (keys) {
      const obj = {};
      for (const key of keys) {
        if (key in result || result.hasOwnProperty(key)) {
          obj[key] = result[key];
        } else if (result["get" + key]) {
          obj[key] = result["get" + key]();
        } else if (Object(result)[key]) {
          obj[key] = Object(result)[key];
        }
      }
      return obj;
    }
    return result || {};
  });
  callback(msg, "node-options", () => {
    const { node_id, attrs, keys } = msg;
    const node = figma.getNodeById(node_id);
    const obj = {};
    if (node) {
      if (attrs) {
        for (const key in attrs) {
          const value = attrs[key];
          if (key in result || result.hasOwnProperty(key)) {
            result[key] = value;
          } else if (result["set" + key]) {
            result["set" + key](value);
          } else if (Object(result)[key]) {
            Object(result)[key] = value;
          }
        }
      }
      if (keys) {
        for (const key of keys) {
          if (key in result || result.hasOwnProperty(key)) {
            obj[key] = result[key];
          } else if (result["get" + key]) {
            obj[key] = result["get" + key]();
          } else if (Object(result)[key]) {
            obj[key] = Object(result)[key];
          }
        }
      } else {
        obj["id"] = node.id;
      }
    }
    return obj;
  });
  callback(msg, "get-node", () => {
    const { node_id, keys } = msg;
    const node = figma.getNodeById(node_id);
    if (node) {
      for (const key in attrs) {
        const value = attrs[key];
        if (key in result || result.hasOwnProperty(key)) {
          result[key] = value;
        } else if (result["set" + key]) {
          result["set" + key](value);
        } else if (Object(result)[key]) {
          Object(result)[key] = value;
        }
      }
      return true;
    } else {
      return false;
    }
  });
  function nodeIdsCallback(cb) {
    const { ids } = msg;
    const sceneNodes = figma.currentPage.findAll((node) => {
      return ids.includes(node.id);
    });
    return cb(sceneNodes);
  }
  callback(msg, "append-to-current-page", () => {
    return nodeIdsCallback((nodes) => {
      for (const node of nodes) {
        figma.currentPage.appendChild(node);
      }
      return true;
    });
  });
  callback(msg, "set-selection", () => {
    return nodeIdsCallback((nodes) => {
      figma.currentPage.selection = nodes;
      return true;
    });
  });
  callback(msg, "scroll-and-zoom-into-view", () => {
    return nodeIdsCallback((nodes) => {
      figma.viewport.scrollAndZoomIntoView(nodes);
      return true;
    });
  });
  if (type === "fetch") {
    let { url, options } = msg;
    if (!url.startsWith("http")) {
      url = `$BASE_URL/${url}`;
    }
    try {
      const res = await fetch(url, options);
      const meta = Object.assign({}, res);
      // Delete functions
      for (const key in meta) {
        if (typeof meta[key] === "function") {
          delete meta[key];
        }
      }
      meta.headers = meta.headersObject;
      delete meta.headersObject;

      const raw = await res.arrayBuffer();
      const result = Object.assign(
        { msg_type: "fetch", result: raw, id },
        meta
      );
      figma.ui.postMessage(result);
    } catch (error) {
      figma.ui.postMessage({ msg_type: "fetch", error, id, headers });
    }
  }
  if (type === "close") {
    const message = msg.message;
    figma.closePlugin(message);
  }
};

async function callback(msg, type, cb) {
  let { id, msg_type } = msg;
  if (type === msg_type) {
    try {
      const result = (await cb()) || {};
      figma.ui.postMessage({ msg_type, result, id });
    } catch (err) {
      const error = err.toString();
      figma.ui.postMessage({ msg_type, error, id });
    }
  }
}
