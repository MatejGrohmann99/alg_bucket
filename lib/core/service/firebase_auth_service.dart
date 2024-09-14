import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../env.dart';

typedef GoogleSignInResponse = Either<({dynamic error, StackTrace stackTrace}),
    ({UserCredential? userCredential, GoogleSignInAccount? googleSignInAccount})>;

typedef GoogleLogoutResponse = Either<({dynamic error, StackTrace stackTrace}), Unit>;

abstract interface class FirebaseAuthService {
  static FirebaseAuthService get instance =>
      isDev ? MockFirebaseAuthService._instance : FirebaseAuthServiceImpl._instance;

  Future<GoogleSignInResponse> signInWithGoogle();

  Future<GoogleSignInResponse> signSilently();

  Future<GoogleLogoutResponse> logOut();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  FirebaseAuthServiceImpl._internal();

  static final FirebaseAuthService _instance = FirebaseAuthServiceImpl._internal();

  GoogleSignIn? googleSignIn;

  bool _initialized = false;

  final String _clientId = '564373388241-3g193r5692t23dm5qqn1sh50ifn8efc3.apps.googleusercontent.com';

  Future<void> initialize() async {
    if (!_initialized) {
      await GoogleSignInPlatform.instance.initWithParams(
        SignInInitParameters(clientId: _clientId),
      );
      _initialized = true;
    }
  }

  @override
  Future<GoogleSignInResponse> signInWithGoogle() async {
    try {
      await initialize();

      googleSignIn = GoogleSignIn(clientId: _clientId);

      final GoogleSignInAccount? googleUser = await googleSignIn?.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return Right((userCredential: userCredential, googleSignInAccount: googleUser));
    } catch (e, s) {
      log(
        e.toString(),
        name: 'signInWithGoogle',
        stackTrace: s,
      );
      return Left((error: e, stackTrace: s));
    }
  }

  @override
  Future<GoogleSignInResponse> signSilently() async {
    try {
      await initialize();

      googleSignIn = GoogleSignIn(clientId: _clientId);

      final GoogleSignInAccount? googleUser = await googleSignIn?.signInSilently();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right((userCredential: userCredential, googleSignInAccount: googleUser));
    } catch (e, s) {
      log(
        e.toString(),
        name: 'signSilently',
        stackTrace: s,
      );
      return Left((error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<({dynamic error, StackTrace stackTrace}), Unit>> logOut() async {
    try {
      await googleSignIn?.signOut();
      await FirebaseAuth.instance.signOut();

      return const Right(unit);
    } catch (e, s) {
      log(
        e.toString(),
        name: 'logOut',
        stackTrace: s,
      );
      return Left((error: e, stackTrace: s));
    }
  }
}

class MockFirebaseAuthService extends FirebaseAuthService {
  MockFirebaseAuthService._internal();

  static final MockFirebaseAuthService _instance = MockFirebaseAuthService._internal();

  @override
  Future<GoogleSignInResponse> signInWithGoogle() {
    return Future.value(const Right((userCredential: null, googleSignInAccount: null)));
  }

  @override
  Future<GoogleSignInResponse> signSilently() {
    return Future.value(const Right((userCredential: null, googleSignInAccount: null)));
  }

  @override
  Future<GoogleLogoutResponse> logOut() {
    return Future.value(const Right(unit));
  }
}
