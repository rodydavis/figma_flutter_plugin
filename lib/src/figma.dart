import 'dart:html' as html;

Future<void> sendMessage(
  String type, [
  Map<String, Object?> data = const {},
]) async {
  final parent = html.window.parent!;
  final message = {
    'pluginMessage': {'type': type, ...data}
  };
  parent.postMessage(message, '*');
}

Stream<Object?> onMessage() async* {}
