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
    let obj = {};
    if (node) {
      if (attrs) {
        for (const key in attrs) {
          const value = attrs[key];
          if (key in node || node.hasOwnProperty(key)) {
            node[key] = value;
          } else if (node["set" + key]) {
            node["set" + key](value);
          } else if (Object(node)[key]) {
            Object(node)[key] = value;
          }
        }
      }
      if (keys) {
        for (const key of keys) {
          if (key in node || node.hasOwnProperty(key)) {
            obj[key] = node[key];
          } else if (node["get" + key]) {
            obj[key] = node["get" + key]();
          } else if (Object(node)[key]) {
            obj[key] = Object(node)[key];
          }
        }
      } else {
        obj = node;
      }
    }
    return obj;
  });
  // callback(msg, "create-table-from-json", async () => {
  //   const obj = {};
  //   if (figma.editorType === "figjam") {
  //     const { items, hide_header } = msg;
  //     const addHeader = hide_header !== true;
  //     if (items.length === 0) return obj;
  //     const header = Object.keys(items[0]);
  //     const headerColumnsCount = header.length;
  //     let rowsCount = items.length;
  //     if (addHeader) rowsCount += 1;
  //     const table = figma.createTable(rowsCount, headerColumnsCount);
  //     let rowIdx = 0;
  //     if (addHeader) {
  //       for (let i = 0; i < headerColumnsCount; i++) {
  //         const node = table.cellAt(rowIdx, i);
  //         const headerText = header[i].toString();
  //         node.text.characters = headerText;
  //       }
  //       rowIdx++;
  //     }
  //     for (const item of Array.from(items)) {
  //       for (let i = 0; i < headerColumnsCount; i++) {
  //         const node = table.cellAt(rowIdx, i);
  //         const value = item[header[i]];
  //         if (typeof value === "object" && "color" in value) {
  //           const color = value.color;
  //           const opacity = value.opacity || undefined;
  //           node.fills = [{ type: "SOLID", color, opacity }];
  //           const text = value.text || "";
  //           node.text.characters = text;
  //         } else {
  //           node.text.characters = value.toString();
  //         }
  //       }
  //       rowIdx++;
  //     }
  //   }
  //   return obj;
  // });
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
