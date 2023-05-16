import 'package:flutter/material.dart';
import 'src/generated/fonts.dart';

import 'src/figma.dart';

void main() async {
  if (bool.fromEnvironment('FIGMA')) await loadFonts();
  runApp(const FigmaPlugin());
}

class FigmaPlugin extends StatelessWidget {
  const FigmaPlugin({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Figma Flutter Plugin';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Example(title: title),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key, required this.title});

  final String title;

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final controller = TextEditingController(text: '5');
  final formKey = GlobalKey<FormState>();
  final api = FigmaApi();

  int red = 0;
  int green = 0;
  int blue = 255;

  @override
  void initState() {
    api.init().then((value) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final color = Color.fromARGB(255, red, green, blue);
    final onColor = color.onColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Builder(builder: (context) {
            return IconButton(
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
              icon: const Icon(Icons.settings),
            );
          }),
        ],
      ),
      body: Theme(
        data: theme.copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            brightness: colors.brightness,
          ),
        ),
        child: !api.initialized
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
