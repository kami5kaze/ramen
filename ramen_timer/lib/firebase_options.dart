// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA02Ew6AE_eEoBXw5np48Fc0xz6FvnkHZE',
    appId: '1:899951608664:web:9a0e5eb5216a61adaf5b2d',
    messagingSenderId: '899951608664',
    projectId: 'ramen-timer-26ef9',
    authDomain: 'ramen-timer-26ef9.firebaseapp.com',
    storageBucket: 'ramen-timer-26ef9.firebasestorage.app',
    measurementId: 'G-6SH5PP2E8V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBOeTJQuhectLi37nIrJATdXsmbZIeZrM',
    appId: '1:899951608664:android:e8042efa67bbbc3daf5b2d',
    messagingSenderId: '899951608664',
    projectId: 'ramen-timer-26ef9',
    storageBucket: 'ramen-timer-26ef9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3ue0EF8-XLi2gs78392Nwm2PA035GLKs',
    appId: '1:899951608664:ios:4599c8e2609f317daf5b2d',
    messagingSenderId: '899951608664',
    projectId: 'ramen-timer-26ef9',
    storageBucket: 'ramen-timer-26ef9.firebasestorage.app',
    iosBundleId: 'com.example.ramenTimer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3ue0EF8-XLi2gs78392Nwm2PA035GLKs',
    appId: '1:899951608664:ios:4599c8e2609f317daf5b2d',
    messagingSenderId: '899951608664',
    projectId: 'ramen-timer-26ef9',
    storageBucket: 'ramen-timer-26ef9.firebasestorage.app',
    iosBundleId: 'com.example.ramenTimer',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA02Ew6AE_eEoBXw5np48Fc0xz6FvnkHZE',
    appId: '1:899951608664:web:ad1fb02e6c55fd74af5b2d',
    messagingSenderId: '899951608664',
    projectId: 'ramen-timer-26ef9',
    authDomain: 'ramen-timer-26ef9.firebaseapp.com',
    storageBucket: 'ramen-timer-26ef9.firebasestorage.app',
    measurementId: 'G-7Z5XSWSZTZ',
  );
}
