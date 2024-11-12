import 'dart:io';

import 'package:args/args.dart';

import 'src/command_arg_parser.dart';
import 'src/generator.dart';
import 'src/package_keys.dart';

void main(List<String> arguments) async {
  try {
    CommandArgParser commandArgParser = CommandArgParser(arguments);
    final ArgParser argParser = commandArgParser.argParser;
    final ArgResults results = commandArgParser.getResults();
    bool verbose = false;
    final String jsonDirectoryPath = results['input-directory'];
    final String outputPath = results['output-class'];

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      _printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('mc_locale_keys_class_generator version: ${PackageKeys().version}');
      return;
    }
    if (results.wasParsed('verbose')) {
      verbose = true;
    }
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }

    File outputFile = await Generator.init(jsonDirectoryPath, outputPath, verbose);
    if (outputFile.existsSync()) {
      stdout.writeln('Generated Dart class has been stored at $outputPath');
      return;
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
  } catch (e) {
    print('An unexpected error occurred: $e');
  }
}

void _printUsage(ArgParser argParser) {
  print('Usage: dart mc_locale_keys_class_generator <flags> [arguments]');
  print(argParser.usage);
}
