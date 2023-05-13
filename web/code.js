/// <reference path="../third_party/figma/index.d.ts" />

figma.showUI(__html__, { width: 400, height: 500 });

figma.ui.onmessage = async (msg) => {
  if (msg.msg_type) {
    switch (msg.msg_type) {
      case "fetch":
        let { url, options, id } = msg;
        if (!url.startsWith("http")) {
          url = `https://rodydavis.github.io/figma_flutter_plugin/${url}`;
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

          console.log('fetch result', result);
          figma.ui.postMessage(result);
        } catch (error) {
          figma.ui.postMessage({ msg_type: "fetch", error, id, headers });
        }
        break;
      default:
        break;
    }
  }
};
