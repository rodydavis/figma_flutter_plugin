import 'package:flutter/material.dart';

import 'example.dart';

class FigmaPlugin extends StatelessWidget {
  const FigmaPlugin({super.key, required this.isFigma});
  final bool isFigma;

  @override
  Widget build(BuildContext context) {
    const title = 'Figma Flutter Plugin';
    const seedColor = Colors.deepPurple;
    return MaterialApp(
      title: title,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: Example(
        title: title,
        seedColor: seedColor,
        isFigma: isFigma,
      ),
    );
  }
}
