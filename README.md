# BUG Mobile Controller

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Deployment on Google Play

To be able to build signed releases you need the store key and a config file with the properties of the key. Place your key somewhere safe and create a file `key.properties` in `android/` with the properties of your key:

```text
storePassword=<pass>
keyPassword=<pass>
keyAlias=bug_key
storeFile=<path_to_bug_key>
```

Now when building an apk it is automatically signed:

```shell
flutter build apk
```

Your apk can be found at `\build\app\outputs\apk\release`