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
    _receive((event) {
      print('Received: $event');
    });
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
