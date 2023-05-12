import 'dart:io';

void main() async {
  print('Building for production...');
  await run('flutter', [
    'build',
    'web',
    '--csp',
    '--pwa-strategy=none',
    '--web-renderer=html',
    '--base-href=/figma_flutter_plugin/',
  ]);
  // <script src="flutter.js" defer></script>
  final outFile = File('build/web/index.html');
  final outFlutterFile = File('build/web/flutter.js');

  // Make sure exists
  if (!outFile.existsSync()) {
    print('Error: build/web/index.html not found');
    exit(1);
  }
  if (!outFlutterFile.existsSync()) {
    print('Error: build/web/flutter.js not found');
    exit(1);
  }

  // Replace script tag with inline script
  final html = await outFile.readAsString();
  final flutterJs = await outFlutterFile.readAsString();
  final sb = StringBuffer();
  sb.writeln('<script>');
  sb.writeln(flutterJs);
  sb.writeln('</script>');
  final newHtml = html.replaceAll(
    '<script src="flutter.js" defer></script>',
    sb.toString(),
  );
  await outFile.writeAsString(newHtml);

  print('Flutter web build complete!');
  exit(0);
}

// Run a command and exit if it fails
Future<void> run(String command, [List<String> args = const []]) async {
  final result = await Process.run(command, args, runInShell: true);
  if (result.exitCode != 0) {
    print(result.stderr);
    exit(result.exitCode);
  }
}
