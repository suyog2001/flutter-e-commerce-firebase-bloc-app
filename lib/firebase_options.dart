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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCfDZXJpDdcMYHSb0uKqIjSV7Fq-j5yrrM',
    appId: '1:897096554846:web:9c403a230be1900c3f57cf',
    messagingSenderId: '897096554846',
    projectId: 'flutter-e-commerce-app-aae15',
    authDomain: 'flutter-e-commerce-app-aae15.firebaseapp.com',
    storageBucket: 'flutter-e-commerce-app-aae15.appspot.com',
    measurementId: 'G-5FSJF5EME6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnIDFrcmjyBLhICR6JHA6mQ44JWNpSnpE',
    appId: '1:897096554846:android:7917d639aca22a3f3f57cf',
    messagingSenderId: '897096554846',
    projectId: 'flutter-e-commerce-app-aae15',
    storageBucket: 'flutter-e-commerce-app-aae15.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIlUvvP6Q0nTGEHUg1glhi6NHx0htjBno',
    appId: '1:897096554846:ios:f2f5b316f37c328c3f57cf',
    messagingSenderId: '897096554846',
    projectId: 'flutter-e-commerce-app-aae15',
    storageBucket: 'flutter-e-commerce-app-aae15.appspot.com',
    androidClientId: '897096554846-7bsmmnreaj0hj8gdbtudqp83bnubv4dg.apps.googleusercontent.com',
    iosClientId: '897096554846-f37hkq6me9kt2cqqk0qpijld0npjfmrk.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterEcommerceApp',
  );
}
