library flutter_launcher_name;

import 'dart:io';

import 'package:flutter_launcher_name/android.dart' as android;
import 'package:flutter_launcher_name/constants.dart' as constants;
import 'package:flutter_launcher_name/constants.dart';
import 'package:flutter_launcher_name/ios.dart' as ios;
import 'package:yaml/yaml.dart';

exec(String name) {
  print(startChangeHelpText);
  try {
    var execName = name;
    final config = loadConfigFile();
    final newName = config['name'];
    if (newName.length >= 1) {
      execName = newName;
    }
    if (execName.length == 0) {
      throw new Exception('flutter_launcher_name was not found');
    }
    print("Flutter Launcher name change to \"$execName\"");
    android.overwriteAndroidManifest(execName);
    ios.overwriteInfoPlist(execName);
    print(changeSuccessText);
  } catch (e) {
    print(changeFailText);
    print(e);
  }
}

Map<String, dynamic> loadConfigFile() {
  final File file = File('pubspec.yaml');
  final String yamlString = file.readAsStringSync();
  final Map yamlMap = loadYaml(yamlString);

  if (yamlMap == null || !(yamlMap[constants.yamlKey] is Map)) {
    // throw new Exception('flutter_launcher_name was not found');
    return <String, dynamic>{
      "name": ""
    };
  }

  // yamlMap has the type YamlMap, which has several unwanted sideeffects
  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap[constants.yamlKey].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}
