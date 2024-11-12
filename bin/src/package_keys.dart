import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class PackageKeys {
  late YamlMap _yamlMap;
  late String version;
  late String name;

  PackageKeys() {
    // Get the current directory
    final String currentDir = Directory.current.path;

    // Construct the path to the pubspec.yaml file relative to the current working directory
    final String yamlPath = path.join(
        currentDir, 'lib', 'current_package', 'pubspec.yaml'); // Adjust the path accordingly

    // Read the yaml file
    final String pubspec = File(yamlPath).readAsStringSync();

    _yamlMap = loadYaml(pubspec) as YamlMap;
    version = _yamlMap['version'];
    name = '${_yamlMap['name']}'.titleCase;
  }
}
