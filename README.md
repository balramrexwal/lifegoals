# Lifegoals

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

Flutter lifegoals app

---

# Current state

Current code has been modularized with attemp to keep core and features separate. 
Within user facing features there is further modularization for presentation logic 
and shared data layer services which can be reused by several user facing services.

![modularization goal](doc/assets/lifegoals_modularization.png)

Note: this approach doesn't yet have needed clarity, so it's fuzzy and is just a part of learning
process of mine. None should take it as best practice.

# Reflections

- VGV Cli creates with Github good development environment really fast, practices are solid.
- Bloc seems to me easy to use and especially test, async logic and subscribing to streams feels complex. 
- Freezed saves boilerplate at Blocs events and states, but it's generator, and if generated code doesn't work or compile it's hard to debug. 
- Go router works well - easy api, well documented - 100% code coverage is challenging, and testing generally
- Firebase auth ui is easy to use, but breaks modularization of architecture, as logic is embedded within ready components
- Firebase auth UI ties you to single cloud provider, and changing it later would be harder than necessary
- Decision to use or not to use Firebase Auth ui boils down to question if one wants to invest on cloud independent solution
- Get_it and Inject seemed also to work, but I'm still experimenting with them, Bloc has different dependency handling
- Firebase and qr/barcode scanner components have problems with ios pods - resul: ios is currently blocked

# Copyrights

During course of testing these question of licensing generated code came up.
VGV clarified this issue in very elegant way. They dropped licencing terms from generated code,
which allows developers to set their own copyright notices in code if they wish.

https://github.com/VeryGoodOpenSource/very_good_cli/issues/210#issuecomment-1335791403

## Command you need repeatedly while experimenting

#### format code

```sh
$ dart format .
```

#### Analyze code

```sh
$ flutter analyze lib test
```

#### Measure code coverage

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
$ genhtml coverage/lcov.info -o coverage/
```

or

```sh
# Run all tests and enforce 100% coverage
$ very_good test --coverage --min-coverage 100
```

#### Generate dependency configurations

just once

```sh
$ flutter packages pub run build_runner build --delete-conflicting-outputs
```

or

generate, stay watching changes and regenerating

```sh
$ flutter packages pub run build_runner watch --delete-conflicting-outputs
```

and remember: after that you need always add ignores to generated config file to pass Github build.

## Ignores needed to generated classes

#### firebase config

add to the start of the file

lib/firebase_options.dart

```
// coverage:ignore-file
// ignore_for_file: no_default_cases
```

note: you need to add these only after *flutterfire configure*

#### injectable config

add to the start of the file

lib/core/injection.config.dart

```
// coverage:ignore-file
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: comment_references
// ignore_for_file: cascade_invocations
// ignore_for_file: require_trailing_commas
```

note: injections configuration is overwritten always when you change injectable annotations or
create class which triggers autogeneration (proposed basic configuration: bloc, repository, service).

## How to repeat creating this app

NOTE: There's currently only needed configs for "production" flavor. Running others flavors might fail.

#### Install very good cli

https://github.com/VeryGoodOpenSource/very_good_cli

https://cli.vgv.dev/

```sh
# install very good cli
$ dart pub global activate very_good_cli
```

#### Create app with very good core as base

https://github.com/VeryGoodOpenSource/very_good_core

https://cli.vgv.dev/docs/templates/core

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

NOTE: I don't know if 21 is correct version, but after this change we get forward

NOTE: You might not want to hardcode your minsdk version as it's done here.

#### create firebase configuration

this step creates *firebase_options.dart* and modifies some existing files

```sh
# create configuration files 
$ flutterfire configure
```

#### Take care of api keys

Generated / modified files contain api keys, which you might not want to commit to git.

- https://firebase.google.com/docs/projects/api-keys

See: iOS/Runner/GoogleService-Info.plist

```
	<key>API_KEY</key>
	<string><secret_you_might_not_want_to_compromize></string>
```

NOTE: It's ok'ish to share api key for firebase if your firebase security definitions are properly done. Pay attention to details.

####  Format generated firebase config

```sh
# format all files according to dart rules
$ flutter format .  
```

Note: there's some rule ignores present, but they might not be all applied 

#### Fix analyse errors in generated firebase config

```sh
# check if we have problems
$ flutter analyze lib test
```

modify generated firebase_options.dart

as it doesn't compile, and it's generated, make minimal changes to get forward.. 

- disable rule: *no_default_cases*

```
// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, no_default_cases
```

generated files might be regenerated later, so you don't want to make them perfect

#### Add router

- https://pub.dev/packages/go_router

```sh
# check if we have problems
$ flutter pub add go_router
```

#### make separate class to routes and router rules

lib/core/navigation.dart

#### Import go router

```
    import 'package:go_router/go_router.dart';
```

#### Add route config

- https://pub.dev/documentation/go_router/latest/topics/Get%20started-topic.html

Define routes

```
class Routes {
  static const home = '/';
}
```

Create function to build router

```
GoRouter router() => GoRouter(
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (_, __) => const CounterPage(),
        )
      ],
    );
```

#### take router config in use

use router constructor 

- https://api.flutter.dev/flutter/material/MaterialApp/MaterialApp.router.html

lib/app/view/app.dart

```
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router(),
    );
```

#### add about page

define new route
- add "about" route 
- add router configuration which points to about page

add counter page button to navigate using new route
- add "i" icon to counter page to navigate to about page with context.go (Routes.about)

create about page component
- add navigation back to counter
- add localizations

#### fix hero tag errors

- https://api.flutter.dev/flutter/material/FloatingActionButton/heroTag.html

added hero tags while there's more than one action button in tree

#### fix 100% code coverage problem

Adding about page was ok, but test code coverage might have dropped

#### install lcov

get tools

```sh
# install lcov (osx)
$ brew install lcov
```

#### check coverage

all but 100% fail at github

```sh
# collect code coverage
$ flutter test --coverage --test-randomize-ordering-seed randomgenhtml coverage/lcov.info -o coverage/

# check if we have problems
$ genhtml coverage/lcov.info -o coverage/
```

#### Rats! Navigation needs to be tested

There isn't ready testing libraries for go router, so we need to do own helpers

Look ideas from here

- https://guillaume.bernos.dev/testing-go-router/
- https://guillaume.bernos.dev/testing-go-router-2/

#### Add mocking for router

https://pub.dev/packages/mocktail

```sh
# add mocking lib
$ flutter pub add mocktail
```

Define mocked router and provider for mocked router

```
class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    super.key,
  });

  /// The mock navigator used to mock navigation calls.
  final MockGoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}
```

#### Write addition test helpers

test/helpers/pump_app.dart

one helper method for mocked routes

```
extension PumpMockRouterApp on WidgetTester {
  Future<void> pumpMockRouterApp(Widget widget, MockGoRouter mockGoRouter) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MockGoRouterProvider(goRouter: mockGoRouter, child: widget),
      ),
    );
  }
}
```

one helper method without mocking for app startup

```
extension PumpRealRouterApp on WidgetTester {
  Future<void> pumpRealRouterApp(GoRouter router) {
    return pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
```

NOTE: If there is persistent state which needs to be filled in state management 
and changes routing rules this logic will become later more complicated 
or test will need to do setup before building app.

NOTE: Might not work with deep linking currently. Not tested as web is not primary target.

#### Write test for default root (/)

```
    testWidgets('renders CounterPage via Router as home screen',
        (tester) async {
      await tester.pumpRealRouterApp(router());
      expect(find.byType(CounterView), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
    });
```

Note: This test should select "/" route as default.

#### Write tests which use mocked router

```
    testWidgets('is redirected when button is tapped', (tester) async {
      final mockGoRouter = MockGoRouter();

      await tester.pumpMockRouterApp(const CounterPage(), mockGoRouter);

      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.go(Routes.about)).called(1);
      verifyNever(() => mockGoRouter.go(Routes.home));
    });
  });
```

#### Set ignores when nothing else helps

Read docs https://pub.dev/packages/coverage

- Use *// coverage:ignore-line* to ignore one line. 
- Use *// coverage:ignore-start* and *// coverage:ignore-end* to ignore range of lines inclusive. 
- Use *// coverage:ignore-file* to ignore the whole file.

NOTE: this is needed as route builders are not used while testing - they are mocked, so: never called.

#### Add firebase initialization

lib/core/appconfig.dart

```
Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // tests never get this far.. even if tests should use this method
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
}
```

Now you have *EmailAuthProvider()* in use, 
so please also configure firebase to allow this authentication method.

#### Create needed screens for sigup / login, forgot password and profile

Each screen needs function which creates it when go router is asking to create widgets for route

lib/core/appconfig.dart

```
/// Sing in to app
Widget singInScreen(BuildContext context) {
  return SignInScreen(
    actions: [
      ForgotPasswordAction(
        (context, email) => context
            .goNamed(Routes.forgotPasswordName, params: {'email': email ?? ''}),
      ),
      AuthStateChangeAction<SignedIn>((context, state) {
        final user = state.user;
        if (user != null) {
          _showVerifyEmailMessage(context, user);
        }
        context.go(Routes.home);
      }),
      AuthStateChangeAction<UserCreated>((context, state) {
        final user = state.credential.user;
        if (user != null) {
          user.updateDisplayName(user.email!.split('@')[0]);
          _showVerifyEmailMessage(context, user);
        }
        context.go(Routes.home);
      }),
    ],
  );
}

void _showVerifyEmailMessage(BuildContext context, User user) {
  final verificationNeeded = !user.emailVerified;
  if (verificationNeeded) {
    user.sendEmailVerification();
    const snackBar = SnackBar(
      // TODO(jnikki): localize
      content: Text('Please check your email to verify your email address'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

/// User has forgotten password
Widget forgotPasswordScreen(BuildContext context, GoRouterState state) {
  final email = state.params['email'] ?? '';
  return ForgotPasswordScreen(email: email, headerMaxExtent: 200);
}

/// User profile
Widget profileScreen(BuildContext context) {
  return ProfileScreen(
    providers: const [],
    actions: [
      SignedOutAction((context) => context.go(Routes.home)),
    ],
  );
}
```

note: this file is currently ignored from code coverage, 
testing it would not be impossible but possibly complicated.

#### add missing routes

forgot password uses named routes, all other is just like before

ignores are used here since calls to routes are mocked and thus never used

```
class Routes {
  static const home = '/';
  static const about = '/about';
  static const login = '/login';
  static const logout = '/logout';
  static const profile = '/profile';
  static const forgotPasswordName = 'forgot';
  static const forgotPasswordPath = '/forgot/:email';
}

GoRouter router() => GoRouter(
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (ctx, state) => const CounterPage(),
        ),
        GoRoute(
          path: Routes.about,
          builder: (ctx, state) => const AboutPage(), // coverage:ignore-line
        ),
        GoRoute(
          path: Routes.login,
          builder: (ctx, state) => singInScreen(ctx), // coverage:ignore-line
        ),
        GoRoute(
          path: Routes.profile,
          builder: (ctx, state) => profileScreen(ctx), // coverage:ignore-line
        ),
        GoRoute(
          name: Routes.forgotPasswordName,
          path: Routes.forgotPasswordPath,
          builder: forgotPasswordScreen, // coverage:ignore-line
        )
      ],
    );
```

#### add freezed (still experimenting with this)

bloc library is fine, but need events and states to be modelled. this can lead to boilerplate code.

freezed is generator which makes it easy to reduce boilerplate. 

- https://pub.dev/packages/freezed

we currently only need these

```sh
$ flutter pub add freezed_annotation
$ flutter pub add --dev build_runner
$ flutter pub add --dev freezed
```

if we want to have json serialization/deserialization we need also

```sh
$ flutter pub add json_annotation
$ flutter pub add --dev json_serializable
```

#### Define model

This model is very simple, only one attribute, no fromJson/toJson 

lib/domain/authentication/authenticated_user.dart

```
@freezed
abstract class AuthenticatedUser with _$AuthenticatedUser {
  const factory AuthenticatedUser({required String name}) = _AuthenticatedUser;
}
```

#### Run generation

```sh
$ flutter pub run build_runner build
```

#### Commit generated code to git

This something I did. Still: It feels somehow wrong..

I would like to generate code to separate source tree and take it in use from there,
but this is something I'll see separately later.

#### Decide how to go forward

1) firebase auth ui changes can be subscribed in bloc and then delivered to ui's

2) one can implement whole ui logic new and do repositories & clients to firebase auth

I go for the first for now, as this is only experimenting. 

#### Listening firebase auth within bloc is unstable?

I did have problems to get it working using bloc multiproviders & tree scopes. 

Still, following presented best practices of bloc library worked at the end.

#### dependency injection to the rescue

I hoped that lazy singleton would be nice hack and give app time to initialize all in right order.

sadly: not. either blocks were closed prematurely or firebase was not initialized correctly.

This wasn't really use case for DI in Flutter, but DI is good for something else, so: experiment it.

#### install get_it & injectable 

add get_it and injectable libraries and code generator for configurations

```sh
$ flutter pub add get_it
$ flutter pub add injectable
$ flutter pub add --dev injectable_generator
```

create configuration file & method method 

- lib/core/injection.dart

```
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
```

generate configs

```sh
$ flutter packages pub run build_runner build --delete-conflicting-outputs
```

Note: At start generation didn't work for me. I needed to add some annotation and not rely
on automatic rules (build.yaml) only and then it start to work.

#### add auto generator for injections (option)

- build.yaml

```
targets:
  $default:
    builders:
      injectable_generator:injectable_builder:
        options:
          auto_register: true
          # auto registers any class with a name matches the given pattern
          class_name_pattern:
            "Service$|Repository$|Bloc$"
          # auto registers any class inside a file with a
          # name matches the given pattern
          file_name_pattern: "_service$|_repository$|_bloc$"
```

#### add setup and teardown to tests for di

Dependency injection rules need to be loaded to memory, but they can be loaded only once.

Each test that needs to use injected resources needs setup & teardown methods.

setUpAll & tearDownAll are run before all tests in test file and after all tests have been executed.

```
void main() {
  setUpAll(configureDependencies);

  tearDownAll(getIt.reset);
```

NOTE: teardown is not needed if tests are executed one by one, but vgv combines cleverly
tests together so that they are faster to execute, which also means that once initialized
getit definitions need to be either shared with all tests or setup / dispose needs to be done per test.

Alternative test setup build could be usage of *flutter_test_config.dart*. Please see more from official docs.

- https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html

#### add mocking of authentication bloc to tests

Create mocked authentication bloc class

```
class MockAuthencationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationStatus>
    implements AuthenticationBloc {}
```

now we need to 

- create instance of mocked bloc
- define what happens when someone interacts with it (here: reads initial state)
- pass it to pumpMockRouterApp, which is changed to support mocked authentication state

```
     testWidgets('is redirected when profile button is tapped',
          (tester) async {
        final mockGoRouter = MockGoRouter();

        final mockAuthenticationBloc = MockAuthencationBloc();

        // TODO(jnikki): handling of initial state is blurry

        // Stub the state stream
        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([AuthenticationStatus.authenticated]),
          initialState: AuthenticationStatus.authenticated,
        );

        await tester.pumpMockRouterApp(
          const CounterPage(),
          mockGoRouter,
          mockAuthenticationBloc,
        );

        await tester.tap(find.byIcon(Icons.verified_user));
        await tester.pumpAndSettle();

        verify(() => mockGoRouter.go(Routes.profile)).called(1);
        verifyNever(() => mockGoRouter.go(Routes.home));
      });
```

Our extension for testing mocked apps has been grown meanwhile

parameter

- we still have widget as parameter
- and allow called to pass in mocked router 
- but we have also authentication bloc as parameter

logic has similarities to real app

- we initialize firebase
- we create material app which has routing rules
- we create provider for authentication bloc above material app
- then we pump widget up

```
extension PumpMockRouterApp on WidgetTester {
  /// pumpMockRouterApp can be used when mocked routing is needed in test
  /// Mocking authentication bloc allows changing easily user state
  Future<void> pumpMockRouterApp(
    Widget widget,
    MockGoRouter mockGoRouter,
    AuthenticationBloc bloc,
  ) {
    initFirebase();

    final app = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MockGoRouterProvider(goRouter: mockGoRouter, child: widget),
    );

    final fullApp = MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (_) => bloc),
      ],
      child: app,
    );

    return pumpWidget(fullApp);
  }
```

#### Blocs & Dependency injection?

Blocs lifecycle and access to it is controlled by widgets it's connected with.

- Bloc defined using BlocProvider above MaterialApp is global
- Global Bloc is shared to whole Presentation layer using buildContext
- BuildContext can be passed using callbacks to further logic, which is quite handy 

With DI you often have one copy (single instance) of something 
created by your DI mechanism and inject it somewhere else. 

- Blocks can have repository injected to them
- Repository might have storage client injected
- Now we can have in test different storage client as during production

I'm trying to find middle way here, since it seems to me that even if domain layer might need
DI / services locators / etc.. presentation layer lives very differently based on bloc and widget / element tree.

#### Adding barcode scanner

I added barcode scanner just to see how to add one more function

- https://pub.dev/packages/mobile_scanner



Adding was simply, define ui with mobile scanner and display for code and add callback handler for barcode coming from mobile scanner. 

Here ui snippet

```
      body: MobileScanner(
        controller: cameraController,
        onDetect: (barcode, args) {
          final code = barcode.rawValue;
          handleReadBarcode(context, code);
        },
      ),
      bottomNavigationBar: const ScannedCode(),
    );
  }
```

here how to give read barcode to bloc

```
 void handleReadBarcode(BuildContext context, String? code) {
    switch (code) {
      case null:
        context.read<ScannerBloc>().add(const ReadFailed());
        break;
      default:
        context.read<ScannerBloc>().add(ReadSucceeded(code!));
        break;
    }
  }
```

And ui component which repains when bloc state changes

```
class ScannedCode extends StatelessWidget {
  const ScannedCode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerBloc, ScannerState>(
      builder: (context, state) => state.maybeWhen(
        found: Text.new,
        orElse: () => const Text('N/A'),
      ),
    );
  }
}
```

With android it functioned without any changes to native shell, with ios rights need to be added.

plist.info

```
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes</string>
```

And there seems to be dependency conflict at ios because of Firebase / ML Toolkit, so; 
I haven't really managed to test iOS implementation, but I guess that after some tweaking
it would work

- https://issuetracker.google.com/issues/254418199?pli=1#comment48

Tricky part was setting up testing. I used high amount of time to mock needed infrastructure.

This is variant where bloc is directly mocked to return requested state.

```
      testWidgets('code is shown when barcode is read', (tester) async {
        final ScannerBloc mockScannerBloc = MockScannerBloc();

        when(() => mockScannerBloc.state).thenReturn(const Found('123'));

        await tester.pumpAppWithProvider(
          const ScannerView(),
          BlocProvider<ScannerBloc>(
            create: (_) => mockScannerBloc,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('123'), findsOneWidget);
      });
```

Here is needed helper method to setup app for testing

```
  Future<void> pumpAppWithProvider(Widget widget, BlocProvider provider) {
    initFirebase();

    final app = MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );

    final fullApp = MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
        provider,
      ],
      child: app,
    );

    return pumpWidget(fullApp);
  }
}
```

It seemed to me that at least some of my problems were up to not using types correctly, 
for example when building widgets *BlocProvider<ScannerBloc>*  seemed to need 
type of bloc or otherwise bloc couldn't be found from tree.

Note that what I have done here is just to give one fully built provider to 
method that I have extended from previous helper methods. 
It seems to me that currently it's nicer to have many simple methods than try to write
test method which can handle lot of needs and is starting to be complex. 
so: copy & paste coding allowed, cleanup happens maybe at some point. 

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
