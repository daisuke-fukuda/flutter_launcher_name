library flutter_launcher_name;

import 'dart:io';

import 'package:args/args.dart';
import 'package:change_app_package_name/android_rename_steps.dart';
import 'package:flutter_launcher_name/android.dart' as android;
import 'package:flutter_launcher_name/constants.dart' as constants;
import 'package:flutter_launcher_name/ios.dart' as ios;
import 'package:yaml/yaml.dart';

const String helpFlag = 'help';
const String fileOption = 'file';

exec(List<String> arguments) {
  print('start');

  final ArgParser parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag(helpFlag, abbr: 'h', help: 'Usage help', negatable: false);
  parser.addOption(fileOption,
      abbr: 'f', help: 'Config file to read (default: pubspec.yaml)');

  final ArgResults argResults = parser.parse(arguments);

  if (argResults[helpFlag]) {
    stdout.writeln('Rename your app to your desired name.');
    stdout.writeln(parser.usage);
    exit(0);
  }

  final config = loadConfigFile(argResults);

  final newName = config['name'];

  print('Change name to $newName');
  android.overwriteAndroidManifest(newName);
  ios.overwriteInfoPlist(newName);

  final bundleId = config['bundleId'];
  if (bundleId != null) {
    print('Change bundleId to $bundleId');
    AndroidRenameSteps(arguments[0]).process();
  }

  print('exit');
}

Map<String, dynamic> loadConfigFile(ArgResults argResults) {
  final String fileName = argResults[fileOption] ?? 'pubspec.yaml';

  final File file = File(fileName);
  final String yamlString = file.readAsStringSync();
  final Map yamlMap = loadYaml(yamlString);

  if (yamlMap == null || !(yamlMap[constants.yamlKey] is Map)) {
    throw new Exception('flutter_launcher_name was not found');
  }

  // yamlMap has the type YamlMap, which has several unwanted sideeffects
  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap[constants.yamlKey].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}
