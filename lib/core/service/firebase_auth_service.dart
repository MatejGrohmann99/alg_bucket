import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../constants.dart';

class FirebaseAuthService {
  FirebaseAuthService._internal();

  static final FirebaseAuthService _instance = FirebaseAuthService._internal();

  static FirebaseAuthService get instance => _instance;

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

  Future<
      Either<({dynamic error, StackTrace stackTrace}),
          ({UserCredential userCredential, GoogleSignInAccount googleSignInAccount})>> signInWithGoogle() async {
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

  Future<
      Either<({dynamic error, StackTrace stackTrace}),
          ({UserCredential? userCredential, GoogleSignInAccount? googleSignInAccount})>> signSilently() async {
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
