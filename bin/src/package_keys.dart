import 'dart:io';

import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class PackageKeys {
  late YamlMap _yamlMap;
  late String version;
  late String name;

  PackageKeys() {
    final String pubspec = File('pubspec.yaml').readAsStringSync();
    _yamlMap = loadYaml(pubspec) as YamlMap;
    version = _yamlMap['version'];
    name = '${_yamlMap['name']}'.titleCase;
  }
}
