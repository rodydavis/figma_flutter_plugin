import 'package:flutter/material.dart';
import 'src/generated/fonts.dart';

import 'src/figma.dart';

void main() async {
  if (bool.fromEnvironment('FIGMA')) await loadFonts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Figma Flutter Plugin';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController(text: '5');
  final formKey = GlobalKey<FormState>();
  final api = FigmaApi();

  @override
  void initState() {
    api.init().then((value) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
      body: Center(
        child: !api.initialized
            ? const CircularProgressIndicator()
            : Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          formKey.currentState!.save();
                          api.createShapes(
                            int.parse(controller.text),
                            Colors.blue,
                          );
                        },
                        label: const Text('Create rectangles'),
                        icon: const Icon(Icons.add, size: 18),
                      ),
                      // const SizedBox(height: 16),
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     api.createTableFromJson([
                      //       {
                      //         'name': 'Primary',
                      //         'token': 'md.sys.color.primary',
                      //         'value': {
                      //           'color': colors.primary.toFigma(),
                      //           'text': colors.primary.toHex(),
                      //         },
                      //       },
                      //       {
                      //         'name': 'Secondary',
                      //         'token': 'md.sys.color.secondary',
                      //         'value': {
                      //           'color': colors.secondary.toFigma(),
                      //           'text': colors.secondary.toHex(),
                      //         },
                      //       }
                      //     ]);
                      //   },
                      //   label: const Text('Create table'),
                      //   icon: const Icon(Icons.table_chart_outlined, size: 18),
                      // ),
                    ],
                  ),
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

extension on Color {
  String toHex() {
    final r = red.toRadixString(16).padLeft(2, '0');
    final g = green.toRadixString(16).padLeft(2, '0');
    final b = blue.toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}
