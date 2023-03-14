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
    apiKey: 'AIzaSyDy3Z2EG7MpnFa1oeH9Rf4lRO9BGaVQ41o',
    appId: '1:993277442886:web:c41acc0ad52a9f97d68347',
    messagingSenderId: '993277442886',
    projectId: 'lost-and-found-4e6be',
    authDomain: 'lost-and-found-4e6be.firebaseapp.com',
    storageBucket: 'lost-and-found-4e6be.appspot.com',
    measurementId: 'G-GPSNC6759B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdDUxD6KRpZF2_NrCqd859WHe3EZUitv8',
    appId: '1:993277442886:android:3140d9870a0cf5d1d68347',
    messagingSenderId: '993277442886',
    projectId: 'lost-and-found-4e6be',
    storageBucket: 'lost-and-found-4e6be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuciyIH8hzyPba96xkbkMv4ZDTdtcHYm0',
    appId: '1:993277442886:ios:32b9b585114ff4eed68347',
    messagingSenderId: '993277442886',
    projectId: 'lost-and-found-4e6be',
    storageBucket: 'lost-and-found-4e6be.appspot.com',
    iosClientId: '993277442886-9ljc7bahsromivv1ed2rrf6g69j74auu.apps.googleusercontent.com',
    iosBundleId: 'com.example.lostfound',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuciyIH8hzyPba96xkbkMv4ZDTdtcHYm0',
    appId: '1:993277442886:ios:32b9b585114ff4eed68347',
    messagingSenderId: '993277442886',
    projectId: 'lost-and-found-4e6be',
    storageBucket: 'lost-and-found-4e6be.appspot.com',
    iosClientId: '993277442886-9ljc7bahsromivv1ed2rrf6g69j74auu.apps.googleusercontent.com',
    iosBundleId: 'com.example.lostfound',
  );
}