library flutter_launcher_name;

import 'package:flutter_launcher_name/android.dart' as android;

exec() {
  print('start');

  android.overwriteAndroidManifest('test');

  print('exit');
}
