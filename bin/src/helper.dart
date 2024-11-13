abstract final class Helper {
  static String attributeCleaner(String key) {
    final List<String> dartKeywords = [
      'abstract',
      'as',
      'assert',
      'async',
      'await',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'covariant',
      'default',
      'deferred',
      'do',
      'dynamic',
      'else',
      'enum',
      'export',
      'extends',
      'extension',
      'external',
      'factory',
      'false',
      'final',
      'finally',
      'for',
      'Function',
      'get',
      'hide',
      'if',
      'implements',
      'import',
      'in',
      'interface',
      'is',
      'late',
      'library',
      'mixin',
      'new',
      'null',
      'on',
      'operator',
      'part',
      'required',
      'rethrow',
      'return',
      'set',
      'show',
      'static',
      'super',
      'switch',
      'sync',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'var',
      'void',
      'while',
      'with',
      'yield'
    ];
    String tmpKey = key;
    if (dartKeywords.contains(key)) {
      tmpKey = '${key}_';
    }
    // Remove Dart symbols from the key
    tmpKey = tmpKey.replaceAll(
        RegExp(r'[’\?\!\@\#\$\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|;\"\:\,\.\/\<\>\~\`]'), '');
    tmpKey = tmpKey.replaceAll("'", '');
    return tmpKey;
  }
}
