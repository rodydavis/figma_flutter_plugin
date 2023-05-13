import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

typedef FigmaJson = Map<String, Object?>;

void sendFigmaMessage(
  String type, [
  FigmaJson data = const {},
]) {
  final parent = html.window.parent!;
  final message = {
    'pluginMessage': {'msg_type': type, ...data}
  };
  parent.postMessage(message, '*');
}

void onFigmaMessage(ValueChanged<FigmaJson> callback) {
  final parent = html.document.getElementById('output')!;
  parent.addEventListener('figma', (event) {
    final customEvent = event as html.CustomEvent;
    final detail = customEvent.detail;
    final result = detail;
    callback(result);
  });
}

Future<FigmaJson> getFigmaResult(
  String type, [
  FigmaJson data = const {},
]) async {
  final completer = Completer<FigmaJson>();
  final id = DateTime.now().millisecondsSinceEpoch.toString();
  onFigmaMessage((event) {
    if (event['id'] == id) {
      completer.complete(event);
    }
  });
  sendFigmaMessage(type, {'id': id, ...data});
  return completer.future;
}
