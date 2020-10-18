import 'dart:io';

String fixture(String filename) => File('test/fixture/$filename').readAsStringSync();
