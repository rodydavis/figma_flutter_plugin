"use strict";
/// <reference path="../third_party/figma/index.d.ts" />
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
figma.showUI(__html__, { width: 350, height: 550 });
figma.ui.onmessage = (msg) => __awaiter(void 0, void 0, void 0, function* () {
    const type = msg.msg_type;
    let { id } = msg;
    callback(msg, "init", () => __awaiter(void 0, void 0, void 0, function* () {
        return ({
            msg_type: type,
            editorType: figma.editorType,
            command: figma.command,
            id,
        });
    }));
    callback(msg, "function", () => __awaiter(void 0, void 0, void 0, function* () {
        const { name, args, attrs, keys } = msg;
        const method = getNestedObject(figma, name);
        if (typeof method !== "function") {
            throw new Error(`Method ${name} not found`);
        }
        const result = yield method(...(args || []));
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
    }));
    callback(msg, "node-options", () => __awaiter(void 0, void 0, void 0, function* () {
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
            }
            else {
                obj = node;
            }
        }
        return obj;
    }));
    callback(msg, "append-to-current-page", () => __awaiter(void 0, void 0, void 0, function* () {
        return nodeIdsCallback(msg, (nodes) => {
            for (const node of nodes) {
                figma.currentPage.appendChild(node);
            }
            return true;
        });
    }));
    callback(msg, "set-selection", () => __awaiter(void 0, void 0, void 0, function* () {
        return nodeIdsCallback(msg, (nodes) => {
            figma.currentPage.selection = nodes;
            return true;
        });
    }));
    callback(msg, "scroll-and-zoom-into-view", () => __awaiter(void 0, void 0, void 0, function* () {
        return nodeIdsCallback(msg, (nodes) => {
            figma.viewport.scrollAndZoomIntoView(nodes);
            return true;
        });
    }));
});
function callback(msg, type, cb) {
    return __awaiter(this, void 0, void 0, function* () {
        let { id, msg_type } = msg;
        if (type === msg_type) {
            try {
                const result = (yield cb()) || {};
                figma.ui.postMessage({ msg_type, result, id });
            }
            catch (err) {
                const error = `${err}`;
                figma.ui.postMessage({ msg_type, error, id });
            }
        }
    });
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
        method = Object(method)[part];
    }
    return method;
}
function setValue(obj, key, value) {
    if (key in obj || obj.hasOwnProperty(key)) {
        Object(obj)[key] = value;
    }
    else if (Object(obj)["set" + key]) {
        Object(obj)["set" + key](value);
    }
    else if (Object(obj)[key]) {
        Object(obj)[key] = value;
    }
}
function getValue(obj, key) {
    if (key in obj || obj.hasOwnProperty(key)) {
        return Object(obj)[key];
    }
    else if (Object(obj)["get" + key]) {
        return Object(obj)["get" + key]();
    }
    else if (Object(obj)[key]) {
        return Object(obj)[key];
    }
    return undefined;
}
