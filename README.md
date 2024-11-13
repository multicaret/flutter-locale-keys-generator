# mc_locale_keys_class_generator

A sample command-line application with basic argument parsing.

## Installation

Ensure you have Dart SDK version 3.5.4 or later installed. Then, add the package to your dependencies:

```bash
dart pub add mc_locale_keys_class_generator
```

## Usage

This package provides a command-line tool to help you with your localization tasks.

### Running the Tool

To use the tool, run the following command in your terminal:

```bash
dart run mc_locale_keys_class_generator
```

### Getting Help

If you need more information on how to use the tool or what options are available, you can use the `-h` flag to display
the help text:

```bash
dart run mc_locale_keys_class_generator -h
```

The help text will display information about the available commands and options.

### Example

Here is an example of how to use the tool:

```bash
dart run mc_locale_keys_class_generator
```

This will generate the localization keys class based on the localization files in your project.

### Command-Line Options

- **`-h`, `--help`**: Print this usage information.
- **`-i`, `--input-directory <path>`**: Set directory that contains all localized JSON files. (Defaults to
  `assets/json/translations/`)
- **`-o`, `--output-class <path>`**: Set output Dart class path. (Defaults to `lib/locale_keys.dart`)
- **`-a`, `--add-to-ignore-file`**: Check if generated Dart class is added to root `.gitignore` file.
- **`-v`, `--verbose`**: Show additional command output.
- **`--version`**: Print the generator version.

### Detailed Command Descriptions

- **`-i`, `--input-directory`**: Use this option to specify the directory containing your localization JSON files. For
  example:
  ```bash
  dart run mc_locale_keys_class_generator -i path/to/your/json/files
  ```

- **`-o`, `--output-class`**: Use this option to specify where the generated Dart class should be saved. For example:
  ```bash
  dart run mc_locale_keys_class_generator -o lib/generated/locale_keys.dart
  ```

- **`-a`, `--add-to-ignore-file`**: Use this flag to ensure that the generated Dart class is added to your root
  `.gitignore` file. For example:
  ```bash
  dart run mc_locale_keys_class_generator -a
  ```

- **`-v`, `--verbose`**: Use this flag to enable verbose output, which will show additional command output. For example:
  ```bash
  dart run mc_locale_keys_class_generator -v
  ```

- **`-h`, `--help`**: Use this flag to print the usage information for all available commands. For example:
  ```bash
  dart run mc_locale_keys_class_generator -h
  ```

- **`--version`**: Use this flag to print the version of the generator. For example:
  ```bash
  dart run mc_locale_keys_class_generator --version
  ```

## Development Environment

### Dependencies

The package relies on the following dependencies:

- `args: ^2.6.0`
- `recase: ^4.1.0`
- `yaml: ^3.1.2`
- `path: ^1.9.0`

### Dev Dependencies

For development, the following dependencies are used:

- `lints: ^5.0.0`
- `test: ^1.25.8`

## Repository

For more details, please refer to the [repository](https://github.com/msk286/locale-keys-generator).

## License

Specify your license information here.