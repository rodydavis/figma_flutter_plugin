import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/generated/fonts.dart';

void main() async {
  const isFigma = bool.fromEnvironment('FIGMA');
  if (isFigma) await loadFonts();
  runApp(const FigmaPlugin(isFigma: isFigma));
}
