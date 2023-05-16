/// <reference path="../third_party/figma/index.d.ts" />

figma.showUI(__html__, { width: 350, height: 550 });

figma.ui.onmessage = async (msg) => {
  const type = msg.msg_type;
  let { id } = msg;
  callback(msg, "init", () => ({
    msg_type: type,
    editorType: figma.editorType,
    command: figma.command,
    id,
  }));
  callback(msg, "function", async () => {
    const { name, args, attrs, keys } = msg;
    const method = getNestedObject(figma, name);
    const result = await method(...(args || []));
    if (attrs) {
      for (const key in attrs) {
        const value = attrs[key];
        setValue(result, key, value);
      }
    }
    if (keys) {
      const obj = {};
      for (const key of keys) {
        obj[key] = getValue(result, key);
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
          setValue(node, key, value);
        }
      }
      if (keys) {
        for (const key of keys) {
          obj[key] = getValue(node, key);
        }
      } else {
        obj = node;
      }
    }
    return obj;
  });
  callback(msg, "append-to-current-page", () => {
    return nodeIdsCallback(msg, (nodes) => {
      for (const node of nodes) {
        figma.currentPage.appendChild(node);
      }
      return true;
    });
  });
  callback(msg, "set-selection", () => {
    return nodeIdsCallback(msg, (nodes) => {
      figma.currentPage.selection = nodes;
      return true;
    });
  });
  callback(msg, "scroll-and-zoom-into-view", () => {
    return nodeIdsCallback(msg, (nodes) => {
      figma.viewport.scrollAndZoomIntoView(nodes);
      return true;
    });
  });
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

function nodeIdsCallback(msg, cb) {
  const { ids } = msg;
  const sceneNodes = figma.currentPage.findAll((node) => {
    return ids.includes(node.id);
  });
  return cb(sceneNodes);
}

function getNestedObject(obj, key) {
  let method = obj;
  const parts = key.split(".");
  for (const part of parts) {
    method = method[part];
  }
  return method;
}

function setValue(obj, key, value) {
  if (key in obj || result.hasOwnProperty(key)) {
    obj[key] = value;
  } else if (obj["set" + key]) {
    obj["set" + key](value);
  } else if (Object(obj)[key]) {
    Object(obj)[key] = value;
  }
}

function getValue(obj, key) {
  if (key in obj || obj.hasOwnProperty(key)) {
    return obj[key];
  } else if (obj["get" + key]) {
    return obj["get" + key]();
  } else if (Object(obj)[key]) {
    return Object(obj)[key];
  }
  return undefined;
}
