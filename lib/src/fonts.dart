import 'dart:ui';

import 'package:flutter/services.dart';
import 'dart:html' as html;

Future<void> loadFonts() async {
  final parent = html.document.getElementById('output')!;
  parent.addEventListener('font', (event) async {
    final e = event as html.CustomEvent;
    final detail = e.detail;
    final family = detail['family'];
    final bytes = Uint8List.fromList(detail['buffer']);
    await loadFontFromList(bytes, fontFamily: family);
  });
}
