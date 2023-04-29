// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCTnjaBydNhilSR33c__0Z17DEwbT47X60',
    appId: '1:785290939532:web:e8dabcba27ceb21b8c3fa9',
    messagingSenderId: '785290939532',
    projectId: 'myskola-5ed3d',
    authDomain: 'myskola-5ed3d.firebaseapp.com',
    storageBucket: 'myskola-5ed3d.appspot.com',
    measurementId: 'G-SV4EVB0P86',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC80i-_T18IqtGttGK-hzMhPm4FEA5BhSM',
    appId: '1:785290939532:android:7ca6473014c34ca08c3fa9',
    messagingSenderId: '785290939532',
    projectId: 'myskola-5ed3d',
    storageBucket: 'myskola-5ed3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxZrvTZWQvztCtw17dHfDz_ELu0PrjtNk',
    appId: '1:785290939532:ios:0702af68219620cf8c3fa9',
    messagingSenderId: '785290939532',
    projectId: 'myskola-5ed3d',
    storageBucket: 'myskola-5ed3d.appspot.com',
    iosClientId: '785290939532-hrpr2tgfelc38ofm4k2pnm0sjvkrqesm.apps.googleusercontent.com',
    iosBundleId: 'com.example.skola',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxZrvTZWQvztCtw17dHfDz_ELu0PrjtNk',
    appId: '1:785290939532:ios:0702af68219620cf8c3fa9',
    messagingSenderId: '785290939532',
    projectId: 'myskola-5ed3d',
    storageBucket: 'myskola-5ed3d.appspot.com',
    iosClientId: '785290939532-hrpr2tgfelc38ofm4k2pnm0sjvkrqesm.apps.googleusercontent.com',
    iosBundleId: 'com.example.skola',
  );
}