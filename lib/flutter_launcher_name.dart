library flutter_launcher_name;

import 'package:flutter_launcher_name/android.dart' as android;
import 'package:flutter_launcher_name/ios.dart' as ios;

exec() {
  print('start');

  // TODO(daisuke-fukuda): get from pubspec
  final newName = 'newName';

  android.overwriteAndroidManifest(newName);
  ios.overwriteInfoPlist(newName);

  print('exit');
}
