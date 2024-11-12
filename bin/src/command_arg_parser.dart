import 'package:args/args.dart';

class CommandArgParser {
  final List<String> _arguments;
  ArgParser _argParser;

  CommandArgParser(List<String> arguments)
      : _arguments = arguments,
        _argParser = _buildArgParser();
  ArgParser get argParser => _argParser;

  ArgResults getResults() {
    ArgParser argParser = _buildArgParser();
    final ArgResults results = argParser.parse(_arguments);
    return results;
  }

  static ArgParser _buildArgParser() {
    return ArgParser()
      ..addOption(
        'input-directory',
        abbr: 'i',
        help: 'Set directory that contains all localized JSON files.',
        defaultsTo: 'assets/json/translations/',
      )
      ..addOption(
        'output-class',
        abbr: 'o',
        help: 'Set output Dart class path.',
        defaultsTo: 'lib/locale_keys.dart',
      )
      ..addFlag(
        'add-to-ignore-file',
        abbr: 'a',
        negatable: false,
        help: 'Check if generated Dart class is added to root `.gitignore` file.',
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Print this usage information.',
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        negatable: false,
        help: 'Show additional command output.',
      )
      ..addFlag(
        'version',
        negatable: false,
        help: 'Print the generator version.',
      );
  }

  void printUsage(ArgParser argParser) {
    print(argParser.usage);
  }
}
