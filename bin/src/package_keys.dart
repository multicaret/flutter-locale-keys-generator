import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class PackageKeys {
  late YamlMap _yamlMap;
  late String version;
  late String name;

  PackageKeys() {
    // Determine the directory of the current script
    final scriptDirectory = path.dirname(Platform.script.toFilePath());

    // Construct the path to the yaml file relative to the current script
    final yamlPath = path.join(scriptDirectory, 'pubspec.yaml');

    // Read the yaml file
    final String pubspec = File(yamlPath).readAsStringSync();

    _yamlMap = loadYaml(pubspec) as YamlMap;
    version = _yamlMap['version'];
    name = '${_yamlMap['name']}'.titleCase;
  }
}
