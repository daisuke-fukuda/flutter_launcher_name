library flutter_launcher_name;

import 'dart:io';

import 'package:flutter_launcher_name/android.dart' as android;
import 'package:flutter_launcher_name/constants.dart' as constants;
import 'package:flutter_launcher_name/ios.dart' as ios;
import 'package:yaml/yaml.dart';

exec() {
  print('════════════════════════════════════════════');
  print("            FLUTTER LAUNCHER NAME           ");
  print('════════════════════════════════════════════');

  final config = loadConfigFile();

  final newName = config['name'];

  print('- Overwriting app name Android');
  android.overwriteAndroidManifest(newName);
  print('- Overwriting app name Android');
  ios.overwriteInfoPlist(newName);

  print('Successfully generated app name');
}

Map<String, dynamic> loadConfigFile() {
  final File file = File('pubspec.yaml');
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
