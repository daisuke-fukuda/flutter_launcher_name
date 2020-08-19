# flutter_launcher_name

A command-line tool which simplifies the task of updating your Flutter app's launcher name.
If you user this package, You don't need modify AndroidManifest.xml or Info.plist.


## :sparkles: What's New


## :book: Guide

#### 1. Setup the config file

Add your Flutter Launcher name configuration to your `pubspec.yaml`.
An example is shown below.

```yaml
dev_dependencies: 
  flutter_launcher_name: "^0.0.1"
  
flutter_launcher_name:
  name: "yourNewAppLauncherName"

```


#### 2. Run the package

After setting up the configuration, all that is left to do is run the package.

```
flutter pub get
flutter pub run flutter_launcher_name:main
```


### Command line parameters

You can try to pass parameters directly after the command to modify your Flutter Launcher name 🌸

```bash
flutter pub run flutter_launcher_name:main "todoApp"
```

Of course, the priority of the `yaml` configuration file is higher than this 👀


## :mag: Attributes

Shown below is the full list of attributes which you can specify within your Flutter Launcher name configuration.

- `name`: The new application launcher name.

