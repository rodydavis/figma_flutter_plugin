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
    // '--dart2js-optimization=O1',
  ]);
  final outFile = File('build/web/index.html');

  // Make sure exists
  if (!outFile.existsSync()) {
    print('Error: build/web/index.html not found');
    exit(1);
  }

  // Replace script tag with inline script
  String html = await outFile.readAsString();
  {
    final jsFile = File('build/web/flutter.js');
    final js = await jsFile.readAsString();
    final sb = StringBuffer();
    sb.writeln('<script>');
    sb.writeln(js);
    sb.writeln('</script>');
    html = html.replaceAll(
      '<script src="flutter.js" defer></script>',
      sb.toString(),
    );
  }
  {
    final jsFile = File('build/web/main.dart.js');
    String js = await jsFile.readAsString();
    final sb = StringBuffer();
    sb.writeln('<script id="app">');
    js = js.replaceAll('self.window.fetch', 'FETCH');
    sb.writeln(js);
    sb.writeln(OVERRIDES);
    sb.writeln('</script>');
    html = html.replaceAll(
      '<script id="app" src="main.dart.js" defer></script>',
      sb.toString(),
    );
  }
  await outFile.writeAsString(html);

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

const OVERRIDES = r'''
// Fix for fetch
function FETCH(url, options = {}) {
  console.log('fetch', url, options);
  return new Promise(function (resolve, reject) {
    const id = Math.random().toString(36).substring(2, 15);
    const message = {
      pluginMessage: {
        msg_type: 'fetch',
        id: id,
        url: url,
        options: options,
      },
    };
    window.parent.postMessage(message, '*');
    window.addEventListener('message', function (event) {
      const msg = event.data.pluginMessage;
      if (msg.msg_type === 'fetch' && msg.id === id) {
        console.log('fetch response', msg);
        if (msg.error) {
          reject(msg.error);
        } else {
          const raw = msg.result; // Array buffer
          resolve(new Response(raw, {
            status: msg.status,
            statusText: msg.statusText,
            headers: msg.headers,
          }));
        }
      }
    });
  });
};

// Override window fetch
window.fetch = FETCH;

// Polyfill history.replaceState
function replaceState(state, title, url) {
  console.log('replaceState', state, title, url);
  return undefined;
}
window.history = window.history || {};
window.history.replaceState = replaceState;
''';
