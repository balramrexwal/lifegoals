# Lifegoals

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

Flutter lifegoals app

---

## How to repeat creating this app

#### Install very good cli

https://github.com/VeryGoodOpenSource/very_good_cli

```sh
# install very good cli
$ dart pub global activate very_good_cli
```

#### Create app with very good core as base

https://github.com/VeryGoodOpenSource/very_good_core

```sh
# create app with very good cli
$ very_good create lifegoals --desc “Flutter lifegoals app" --org “fi.nikkijuk.lifegoals”
```

#### Configure firebase

- https://firebase.google.com/codelabs/firebase-get-to-know-flutter#2

Create account to https://firebase.google.com/

Go to Firebase console https://console.firebase.google.com/

Create firebase instance 'lifegoals'

#### install firebase cli

- https://github.com/firebase/firebase-tools

```sh
# use brew (osx) to install firebase cli
$ brew install firebase-cli
```

#### Login and Check firebase project

brew install firebase-cli

```sh
# login to firebase
$ firebase login

# list all projects
$ firebase projects:list
```

#### Install firebase dependencies

make sure that you are at project directory

```sh
# core
$ flutter pub add firebase_core

# authentication
$ flutter pub add firebase_auth

# authentication ui components
$ flutter pub add firebase_ui_auth

# firestore
$ flutter pub add cloud_firestore
```

Note: You might need to go to Android studio and update dependency versions manually due to incompatibility of dependencies.

#### fix problem with api levels

open android/app/build.gradle

change min sdk level to be 21 

```
    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "fi.nikkijuk.lifegoals.lifegoals"
        minSdkVersion 21 // flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

Note: I don't know if 21 is correct version, but after this change we get forward

####  Format generated firebase config

```sh
# format all files according to dart rules
$ flutter format .  
```

#### Fix analyse errors in generated firebase config

```sh
# check if we have problems
$ flutter analyze lib test
```

modify to firebase_options.dart

- disable rule: no_default_cases

```
// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, no_default_cases
```

## Flavors 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Lifegoals works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:lifegoals/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
