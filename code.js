/// <reference path="../third_party/figma/index.d.ts" />

figma.showUI(__html__, { width: 400, height: 500 });

figma.ui.onmessage = async (msg) => {
  const type = msg.msg_type;
  if (type === "fetch") {
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

      console.log("fetch result", result);
      figma.ui.postMessage(result);
    } catch (error) {
      figma.ui.postMessage({ msg_type: "fetch", error, id, headers });
    }
  }
  if (type === "close") {
    const message = msg.message;
    figma.closePlugin(message);
  }
  if (figma.editorType === "figma") {
    if (type === "create-shapes") {
      const nodes = [];
      for (let i = 0; i < msg.count; i++) {
        const rect = figma.createRectangle();
        rect.x = i * 150;
        rect.fills = [{ type: "SOLID", color: { r: 1, g: 0.5, b: 0 } }];
        figma.currentPage.appendChild(rect);
        nodes.push(rect);
      }
      figma.currentPage.selection = nodes;
      figma.viewport.scrollAndZoomIntoView(nodes);
    }
  } else {
    if (type === "create-shapes") {
      const numberOfShapes = msg.count;
      const nodes = [];
      for (let i = 0; i < numberOfShapes; i++) {
        const shape = figma.createShapeWithText();
        // You can set shapeType to one of: 'SQUARE' | 'ELLIPSE' | 'ROUNDED_RECTANGLE' | 'DIAMOND' | 'TRIANGLE_UP' | 'TRIANGLE_DOWN' | 'PARALLELOGRAM_RIGHT' | 'PARALLELOGRAM_LEFT'
        shape.shapeType = "ROUNDED_RECTANGLE";
        shape.x = i * (shape.width + 200);
        shape.fills = [{ type: "SOLID", color: { r: 1, g: 0.5, b: 0 } }];
        figma.currentPage.appendChild(shape);
        nodes.push(shape);
      }

      for (let i = 0; i < numberOfShapes - 1; i++) {
        const connector = figma.createConnector();
        connector.strokeWeight = 8;

        connector.connectorStart = {
          endpointNodeId: nodes[i].id,
          magnet: "AUTO",
        };

        connector.connectorEnd = {
          endpointNodeId: nodes[i + 1].id,
          magnet: "AUTO",
        };
      }

      figma.currentPage.selection = nodes;
      figma.viewport.scrollAndZoomIntoView(nodes);
    }
  }
};
