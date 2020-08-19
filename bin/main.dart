import 'package:flutter_launcher_name/flutter_launcher_name.dart'
    as FlutterName;

main(List<String> arguments) {
  var len = arguments.length;
  var name = "";
  if (len >= 1) {
    name = arguments[0];
  }
  FlutterName.exec(name);
}
