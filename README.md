# figma_flutter_plugin

This is an example of how to build a Figma plugin using Flutter web and inline all the assets in the single html file as required by the Figma plugin API.

## Features

- Tree shaking for Material Icons
- Inline assets / fonts
- Offline support in Figma (Not using remote views)
- Two way communication between Flutter and Figma
- Figma and FigJam support
- Build scripts for generating figma project `/build/figma`
- Typings for Figma API
- Light and Dark mode support

## Prerequisites

### Plugin ID

You will need to get a new Figma plugin ID by opening Figma Desktop App and creating a new plugin. Then copy the ID to the `figma/manifest.json` and also update the name key.

### Typings

Make sure to check out the repo with submodules if you want the Figma typings.

```bash
git submodule update --init --recursive
```

### Flutter

You need to update the name and description in `pubspec.yaml`.

### Figma

To use the plugin you need to import the manifest from the `build/figma` folder, not the top level `figma` folder.

Run the build script:

```bash
dart scripts/build.dart
```

Then open figma and import the manifest.json from the `build/figma` folder.

## Screenshots

### Figma

![](/screenshots/figma-preview.png)

### FigJam

![](/screenshots/figjam-preview.png)

## Example

### UI

```dart
import 'package:flutter/material.dart';

import 'figma.dart';

class Example extends StatefulWidget {
  const Example({
    super.key,
    required this.title,
    required this.seedColor,
    required this.isFigma,
  });

  final String title;
  final Color seedColor;
  final bool isFigma;

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final controller = TextEditingController(text: '5');
  final formKey = GlobalKey<FormState>();
  final api = FigmaApi();

  late int red = widget.seedColor.red;
  late int green = widget.seedColor.green;
  late int blue = widget.seedColor.blue;

  @override
  void initState() {
    if (widget.isFigma) {
      api.init().then((value) => setState(() {}));
    } else {
      api.initialized = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final color = Color.fromARGB(255, red, green, blue);
    final onColor = color.onColor();
    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
          brightness: colors.brightness,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () async {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Material(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.notifications),
                              title: Text('Show notification'),
                              onTap: () => api.notify('Hello from Flutter!'),
                            ),
                            ListTile(
                              leading: Icon(Icons.close),
                              title: Text('Close Plugin'),
                              textColor: colors.error,
                              iconColor: colors.error,
                              onTap: () => api.closePlugin(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ],
        ),
        body: !api.initialized
            ? const CircularProgressIndicator()
            : Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.color_lens, color: Colors.red),
                      title: Text('Red'),
                      subtitle: Slider(
                        value: red.toDouble(),
                        min: 0,
                        max: 255,
                        divisions: 255,
                        onChanged: (value) =>
                            setState(() => red = value.toInt()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading:
                          const Icon(Icons.color_lens, color: Colors.green),
                      title: Text('Green'),
                      subtitle: Slider(
                        value: green.toDouble(),
                        min: 0,
                        max: 255,
                        divisions: 255,
                        onChanged: (value) =>
                            setState(() => green = value.toInt()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.color_lens, color: Colors.blue),
                      title: Text('Blue'),
                      subtitle: Slider(
                        value: blue.toDouble(),
                        min: 0,
                        max: 255,
                        divisions: 255,
                        onChanged: (value) =>
                            setState(() => blue = value.toInt()),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number of rectangles',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: onColor,
                      ),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        formKey.currentState!.save();
                        api.createShapes(int.parse(controller.text), color);
                      },
                      label: const Text('Create rectangles'),
                      icon: const Icon(Icons.add, size: 18),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

extension on FigmaApi {
  Future<void> createShapes(int count, Color color) async {
    final ids = <String>[];
    for (var i = 0; i < count; i++) {
      if (type == FigmaEditorType.figma) {
        final res = await execMethod(
          'createRectangle',
          attributes: {
            'x': i * 150,
            'fills': [
              {
                'type': 'SOLID',
                'color': color.toFigma(),
              },
            ],
          },
          keys: ['id', 'name'],
        );
        final result = res['result'] as Map;
        final id = result['id']?.toString();
        if (id != null) ids.add(id);
      } else {
        final res = await execMethod(
          'createShapeWithText',
          attributes: {
            'shapeType': FigJamShapeType.ROUNDED_RECTANGLE.name,
            'fills': [
              {
                'type': 'SOLID',
                'color': color.toFigma(),
              },
            ],
          },
          keys: ['id', 'name', 'width'],
        );
        print(res);
        final result = res['result'] as Map;
        final id = result['id']?.toString();
        if (id != null) {
          ids.add(id);
          final width = num.parse(result['width'].toString());
          await nodeOptions(id, attributes: {
            'x': i * (width + 200),
          });
        }
      }
    }

    if (type == FigmaEditorType.figJam) {
      for (var i = 0; i < ids.length - 1; i++) {
        await execMethod(
          'createConnector',
          attributes: {
            'strokeWeight': 8,
            'connectorStart': {
              'endpointNodeId': ids[i],
              'magnet': 'AUTO',
            },
            'connectorEnd': {
              'endpointNodeId': ids[i + 1],
              'magnet': 'AUTO',
            },
          },
        );
      }
    }

    await appendToCurrentPage(ids);
    await setSelection(ids);
    await scrollAndZoomIntoView(ids);
  }
}

```

### Figma

```dart
import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';

class FigmaApi {
  FigmaEditorType type = FigmaEditorType.figma;
  String command = '';
  String pluginId = '';
  bool initialized = false;

  Future<void> init() async {
    final info = await _result('init');
    final result = info['result'] as Map;
    final editorType = (result['editorType'] ?? 'figma').toString();
    if (editorType == 'figma') {
      type = FigmaEditorType.figma;
    } else {
      type = FigmaEditorType.figJam;
    }
    command = result['command']?.toString() ?? '';
    pluginId = result['id']?.toString() ?? '';
    initialized = true;
    print('Editor: $type');
    print('Command: "$command"');
    print('Plugin ID: $pluginId');
  }

  Future<FigmaJson> execMethod(
    String name, {
    List<String> args = const [],
    FigmaJson attributes = const {},
    List<String>? keys,
  }) async {
    return _result('function', {
      'name': name,
      'attrs': attributes,
      'args': args,
      if (keys != null) 'keys': keys,
    });
  }

  Future<FigmaJson> notify(
    String message, {
    int? timeout,
    bool? error,
  }) async {
    return execMethod(
      'notify',
      args: [message],
      attributes: {
        if (timeout != null) 'timeout': timeout,
        if (error != null) 'error': error,
      },
    );
  }

  Future<FigmaJson> execCallback(
    String name, {
    FigmaJson attributes = const {},
  }) async {
    return _result(name, attributes);
  }

  Future<FigmaJson> nodeOptions(
    String nodeId, {
    FigmaJson attributes = const {},
    List<String>? keys,
  }) async {
    return _result('node-options', {
      'node_id': nodeId,
      'attrs': attributes,
      if (keys != null) 'keys': keys,
    });
  }

  Future<void> appendToCurrentPage(List<String> ids) async {
    await execCallback('append-to-current-page', attributes: {'ids': ids});
  }

  Future<void> setSelection(List<String> ids) async {
    await execCallback('set-selection', attributes: {'ids': ids});
  }

  Future<void> scrollAndZoomIntoView(List<String> ids) async {
    await execCallback('scroll-and-zoom-into-view', attributes: {'ids': ids});
  }

  Future<void> closePlugin([String? message]) async {
    await execMethod('closePlugin', args: [
      if (message != null) message,
    ]);
  }

  void _send(
    String type, [
    FigmaJson data = const {},
  ]) {
    final parent = html.window.parent!;
    final message = {
      'pluginMessage': {'msg_type': type, ...data}
    };
    parent.postMessage(message, '*');
  }

  void _receive(ValueChanged<FigmaJson> callback) {
    final parent = html.document.getElementById('output')!;
    parent.addEventListener('figma', (event) {
      final customEvent = event as html.CustomEvent;
      final detail = customEvent.detail;
      final result = detail;
      callback(result);
    });
  }

  Future<FigmaJson> _result(
    String type, [
    FigmaJson data = const {},
  ]) async {
    final completer = Completer<FigmaJson>();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _receive((event) {
      if (event['id'] == id) {
        completer.complete(event);
      }
    });
    _send(type, {'id': id, ...data});
    return completer.future;
  }
}

extension FigmaColorUtils on Color {
  /// RGB values between 0 and 1
  Map<String, double> toFigma() {
    return {
      'r': red / 255,
      'g': green / 255,
      'b': blue / 255,
    };
  }

  String toHex() {
    final r = red.toRadixString(16).padLeft(2, '0');
    final g = green.toRadixString(16).padLeft(2, '0');
    final b = blue.toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }

  Color onColor() {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

typedef FigmaJson = Map<String, Object?>;

enum FigmaEditorType {
  figma,
  figJam,
}

enum FigJamShapeType {
  SQUARE,
  ELLIPSE,
  ROUNDED_RECTANGLE,
  DIAMOND,
  TRIANGLE_UP,
  TRIANGLE_DOWN,
  PARALLELOGRAM_RIGHT,
  PARALLELOGRAM_LEFT,
}

```
