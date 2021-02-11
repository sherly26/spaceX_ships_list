import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:args/args.dart';

void main(List<String> args) async {
  final parser = new ArgParser()
    ..addOption('apiKey', defaultsTo: "")
    ..addOption('apiUrl', defaultsTo: "")
		..addOption('ipApi', defaultsTo: "https://api64.ipify.org/?format=json");

  final ArgResults argResults = parser.parse(args);
  String envConfig = _generateEnvConfig(argResults, args);
  await _createEnvFile(envConfig);
}

String _generateEnvConfig(ArgResults argResults, List<String> argsKeys) {
  var configMapValues = argResults.options
      .toList()
      .map((key) => '\'$key\'' + ' : \'' + '${argResults[key]}\'')
      .join(
        ',',
      );
  final config = Class((classBuilder) => classBuilder
    ..name = 'EnvConfig'
    ..fields.addAll([
      Field(
        (field) => field
          ..name = 'configs'
          ..type = Reference('Map<String, String>')
          ..assignment = Code('{ $configMapValues }')
          ..static = true
          ..modifier = FieldModifier.constant,
      ),
    ]));
  final emitter = DartEmitter();
  return DartFormatter().format('${config.accept(emitter)}');
}

Future<void> _createEnvFile(String classDefinition) async {
  String completePath = path.join('lib', 'config', 'env_config.dart');
  File quotesFile = new File(completePath);

  try {
    await quotesFile.writeAsString(classDefinition, mode: FileMode.write);
    print('Data written.');
  } catch (e) {
    print(e.toString());
  }
}
