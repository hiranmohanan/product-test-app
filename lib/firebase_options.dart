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
    apiKey: 'AIzaSyCIZNH9AV1DdI0uVV_7wHkTfPtQF8Ey4QE',
    appId: '1:48796781692:web:75fd0fb8d3cace8dfecdf9',
    messagingSenderId: '48796781692',
    projectId: 'product-app-c13de',
    authDomain: 'product-app-c13de.firebaseapp.com',
    storageBucket: 'product-app-c13de.appspot.com',
    measurementId: 'G-VQJE98BPNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkJ3NyAnZAfRk2b5IqKnHNs84r7vRXQLw',
    appId: '1:48796781692:android:a45754a0b6196b9efecdf9',
    messagingSenderId: '48796781692',
    projectId: 'product-app-c13de',
    storageBucket: 'product-app-c13de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLcdf2c_5SDaf1E9ecBNOjXBg_N-ka3hk',
    appId: '1:48796781692:ios:d0c97d0884fee5ebfecdf9',
    messagingSenderId: '48796781692',
    projectId: 'product-app-c13de',
    storageBucket: 'product-app-c13de.appspot.com',
    iosBundleId: 'com.example.productApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLcdf2c_5SDaf1E9ecBNOjXBg_N-ka3hk',
    appId: '1:48796781692:ios:add4722b8fb24ff1fecdf9',
    messagingSenderId: '48796781692',
    projectId: 'product-app-c13de',
    storageBucket: 'product-app-c13de.appspot.com',
    iosBundleId: 'com.example.productApp.RunnerTests',
  );
}
