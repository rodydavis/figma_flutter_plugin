/// <reference path="../third_party/figma/index.d.ts" />

figma.showUI(__html__, { width: 350, height: 550 });

figma.ui.onmessage = async (msg) => {
    const type = msg.msg_type;
    let { id } = msg;
    callback(msg, "init", async () => ({
        msg_type: type,
        editorType: figma.editorType,
        command: figma.command,
        id,
    }));
    callback(msg, "function", async () => {
        const { name, args, attrs, keys } = msg;
        const method = getNestedObject(figma, name);
        if (typeof method !== "function") {
            throw new Error(`Method ${name} not found`);
        }
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
                Object(obj)[key] = getValue(result, key);
            }
            return obj;
        }
        return result || {};
    });
    callback(msg, "node-options", async () => {
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
                    Object(obj)[key] = getValue(node, key);
                }
            } else {
                obj = node;
            }
        }
        return obj;
    });
    callback(msg, "append-to-current-page", async () => {
        return nodeIdsCallback(msg, (nodes) => {
            for (const node of nodes) {
                figma.currentPage.appendChild(node);
            }
            return true;
        });
    });
    callback(msg, "set-selection", async () => {
        return nodeIdsCallback(msg, (nodes) => {
            figma.currentPage.selection = nodes;
            return true;
        });
    });
    callback(msg, "scroll-and-zoom-into-view", async () => {
        return nodeIdsCallback(msg, (nodes) => {
            figma.viewport.scrollAndZoomIntoView(nodes);
            return true;
        });
    });
};

figma.on("selectionchange", () => {
    const selection = figma.currentPage.selection;
    const ids = selection.map((node) => node.id);
    figma.ui.postMessage({ msg_type: "selectionchange", ids });
});
figma.on("currentpagechange", () => {
    const currentPage = figma.currentPage;
    const id = currentPage.id;
    figma.ui.postMessage({ msg_type: "currentpagechange", id });
});
figma.on("close", () => {
    figma.ui.postMessage({ msg_type: "close" });
});
figma.on("timerstart", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timerstart", timer });
});
figma.on("timerstop", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timerstop", timer });
});
figma.on("timerpause", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timerpause", timer });
});
figma.on("timerresume", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timerresume", timer });
});
figma.on("timeradjust", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timeradjust", timer });
});
figma.on("timerdone", () => {
    const timer = figma.timer;
    figma.ui.postMessage({ msg_type: "timerdone", timer });
});
figma.on("documentchange", (event) => {
    const changes = event.documentChanges;
    figma.ui.postMessage({ msg_type: "documentchange", changes });
});
figma.on("run", () => {
    const command = figma.command;
    figma.ui.postMessage({ msg_type: "run", command });
});

async function callback(msg: { id: string, msg_type: string }, type: string, cb: () => Promise<unknown>) {
    let { id, msg_type } = msg;
    if (type === msg_type) {
        try {
            const result = (await cb()) || {};
            figma.ui.postMessage({ msg_type, result, id });
        } catch (err: unknown) {
            const error = `${err}`;
            figma.ui.postMessage({ msg_type, error, id });
        }
    }
}

function nodeIdsCallback(msg: { ids: string[] }, cb: (sceneNodes: SceneNode[]) => unknown) {
    const { ids } = msg;
    const sceneNodes = figma.currentPage.findAll((node) => {
        return ids.includes(node.id);
    });
    return cb(sceneNodes);
}

function getNestedObject(obj: object, key: string): unknown {
    let method = obj;
    const parts = key.split(".");
    for (const part of parts) {
        method = Object(method)[part];
    }
    return method;
}

function setValue(obj: object, key: string, value: unknown) {
    if (key in obj || obj.hasOwnProperty(key)) {
        Object(obj)[key] = value;
    } else if (Object(obj)["set" + key]) {
        Object(obj)["set" + key](value);
    } else if (Object(obj)[key]) {
        Object(obj)[key] = value;
    }
}

function getValue(obj: object, key: string) {
    if (key in obj || obj.hasOwnProperty(key)) {
        return Object(obj)[key];
    } else if (Object(obj)["get" + key]) {
        return Object(obj)["get" + key]();
    } else if (Object(obj)[key]) {
        return Object(obj)[key];
    }
    return undefined;
}
