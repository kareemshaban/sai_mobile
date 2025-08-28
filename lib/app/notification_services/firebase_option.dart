import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
      case TargetPlatform.windows:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtZmp1yG6TqRcavoXvZ1BcAW5umNqaXXY',
    appId: '1:276993027563:android:ad20bfceee862a41f67dae',
    messagingSenderId: '276993027563',
    projectId: 'arab-live-271b4',
    storageBucket: 'arab-live-271b4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbrvOCOAawwWycjC63Vjo39U4gnEJ2di8',
    appId: '1:276993027563:ios:c939c69887c55545f67dae',
    messagingSenderId: '276993027563',
    projectId: 'arab-live-271b4',
    storageBucket: 'arab-live-271b4.firebasestorage.app',
  );
}
