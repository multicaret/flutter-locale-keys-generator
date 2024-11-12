import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

import 'package_keys.dart';

class Generator {
  final String _jsonDirectoryPath;
  final String _outputPath;
  final bool _verbose;

  Generator._(this._jsonDirectoryPath, this._outputPath, this._verbose);

  static Future<File> init(String jsonDirectoryPath, String outputPath, bool verbose) async {
    Generator generator = Generator._(jsonDirectoryPath, outputPath, verbose);
    return await generator._saveToFile();
  }

  /// Function to load all JSON files and merge their keys
  Future<Map<String, dynamic>> _loadAndMergeJsonFiles() async {
    _printIfVerbose('Load all JSON files and merge their keys');
    final Directory directory = Directory(_jsonDirectoryPath);
    if (!directory.existsSync()) {
      throw FileSystemException('Directory not found', _jsonDirectoryPath);
    }

    final Map<String, dynamic> mergedMap = {};
    await for (FileSystemEntity entity in directory.list(recursive: false, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.json')) {
        _printIfVerbose('Load ${entity.path} file keys');
        final String jsonString = await entity.readAsString();
        final dynamic jsonMap = json.decode(jsonString);
        if (jsonMap is Map<String, dynamic>) {
          if (entity.path.endsWith('en.json') || entity.path.endsWith('english.json')) {
            mergedMap.addAll(jsonMap);
          } else {
            jsonMap.forEach((String key, dynamic value) {
              mergedMap.putIfAbsent(key, () => value);
            });
          }
        }
      }
    }
    return mergedMap;
  }

  /// Function to get class name from output file path
  String _getClassNameFromPath() {
    final String fileName = _outputPath.split('/').last.split('.').first;
    return fileName.pascalCase;
  }

  /// Function to generate abstract class with static const attributes
  Future<String> _generateAbstractClass() async {
    _printIfVerbose('Generate abstract class with static const attributes');
    Map<String, dynamic> jsonMap = await _loadAndMergeJsonFiles();

    String className = _getClassNameFromPath();

    final StringBuffer buffer = StringBuffer();

    buffer.writeln('// DO NOT EDIT. This is code generated via "${PackageKeys().name}"');
    buffer.writeln();
    buffer.writeln('abstract final class $className {');

    jsonMap.forEach((String mainKey, value) {
      buffer.writeln('  // ${mainKey.camelCase} = "${value.toString()}"');
      buffer.writeln('  static const String ${mainKey.camelCase} = \'$mainKey\';');
      if (value is Map<String, dynamic>) {
        buffer.writeln('  // Attributes under key "${mainKey.camelCase}"');
        _generateNestedAttributes(mainKey, value, buffer, mainKey);
      }
    });

    buffer.writeln('}');
    return buffer.toString();
  }

  // Function to save generated class to a file
  Future<File> _saveToFile() async {
    _printIfVerbose('Save generated class to a file');
    final String content = await _generateAbstractClass();
    final File file = File(_outputPath);
    final Directory dir = file.parent;
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return await file.writeAsString(content);
  }

  // Recursive function to handle nested JSON structure
  void _generateNestedAttributes(
      String parentKey, Map<String, dynamic> jsonMap, StringBuffer buffer,
      [String prefix = '']) {
    jsonMap.forEach((String key, value) {
      final String updatedKey = '$prefix${key.pascalCase}';
      if (value is String) {
        buffer.writeln('  // $updatedKey = "${value.toString()}"');
        buffer.writeln('  static const String $updatedKey = \'$parentKey.$key\';');
      } else if (value is Map<String, dynamic>) {
        _generateNestedAttributes('$parentKey.$key', value, buffer, updatedKey);
      }
    });
  }

  void _printIfVerbose(String msg) {
    if (_verbose) {
      stdout.writeln(msg);
    }
  }
}
