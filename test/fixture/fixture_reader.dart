import 'dart:io';

String fixture(String filename) {
  // https://github.com/flutter/flutter/issues/20907
  if (Directory.current.path.endsWith("/test")) {
    Directory.current = Directory.current.parent;
  }
  return File("test/fixture/$filename").readAsStringSync();
}
