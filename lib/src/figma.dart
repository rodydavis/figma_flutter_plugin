@JS()
library figma;

import 'package:js/js.dart';
// import 'package:js/js_util' as js;

void main() {}

@JS()
class Console {}

extension on Console {
  external void log(Object? message, [List<Object?>? optionalParams]);
  // external void error(Object? message, [List<Object?>? optionalParams]);
  // @JSExport('assert')
  // external void assertion(bool condition, String? message,
  //     [List<Object?>? data]);
  external void clear();
}
