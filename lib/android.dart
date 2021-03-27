import 'dart:io';

import 'package:flutter_launcher_name/constants.dart' as constants;

/// Updates the line which specifies the launcher label within the AndroidManifest.xml
/// with the new name (only if it has changed)
Future<void> overwriteAndroidManifest(String? name) async {
  final File androidManifestFile = File(constants.androidManifestFile);
  final List<String> lines = await androidManifestFile.readAsLines();
  for (int x = 0; x < lines.length; x++) {
    String line = lines[x];
    if (line.contains('android:label')) {
      // Using RegExp replace the value of android:icon to point to the new label
      // anything but a quote of any length: [^"]*
      // an escaped quote: \\" (escape slash, because it exists regex)
      // quote, no quote / quote with things behind : \"[^"]*
      // repeat as often as wanted with no quote at start: [^"]*(\"[^"]*)*
      // escaping the slash to place in string: [^"]*(\\"[^"]*)*"
      // result: any string which does only include escaped quotes
      line = line.replaceAll(
          RegExp(r'android:label="[^"]*(\\"[^"]*)*"'), 'android:label="$name"');
      lines[x] = line;
      // used to stop git showing a diff if the icon name hasn't changed
      lines.add('');
    }
  }
  androidManifestFile.writeAsString(lines.join('\n'));
}
