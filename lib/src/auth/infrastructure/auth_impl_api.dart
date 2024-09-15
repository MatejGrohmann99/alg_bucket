import 'dart:developer';

import 'package:alg_bucket/src/auth/domain/auth_api_interface.dart';
import 'package:alg_bucket/src/auth/domain/user_data.dart';
import 'package:alg_bucket/src/shared/domain/error_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../../shared/domain/maybe.dart';

class AuthImplApi implements AuthApiInterface {
  bool _initialized = false;

  GoogleSignIn? _googleSignIn;

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
  Future<Maybe<UserData>> signInWithGoogle() async {
    try {
      await initialize();

      _googleSignIn = GoogleSignIn(clientId: _clientId);

      final GoogleSignInAccount? googleUser = await _googleSignIn?.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return Right(
        UserData(
          displayName: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        ),
      );
    } catch (e, s) {
      log(
        e.toString(),
        name: 'signInWithGoogle',
        stackTrace: s,
      );
      return ErrorResponse.from(
        message: 'Error signing in with Google',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<Maybe<UserData>> signSilently() async {
    try {
      await initialize();

      _googleSignIn = GoogleSignIn(clientId: _clientId);

      final GoogleSignInAccount? googleUser = await _googleSignIn?.signInSilently();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return Right(
        UserData(
          displayName: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        ),
      );
    } catch (e, s) {
      log(
        e.toString(),
        name: 'signSilently',
        stackTrace: s,
      );

      return ErrorResponse.from(
        message: 'Error signing in silently with Google',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<Maybe<Unit>> logOut() async {
    try {
      await _googleSignIn?.signOut();
      await FirebaseAuth.instance.signOut();

      return const Right(unit);
    } catch (e, s) {
      log(
        e.toString(),
        name: 'logOut',
        stackTrace: s,
      );

      return ErrorResponse.from(
        message: 'Error logging out',
        error: e,
        stackTrace: s,
      );
    }
  }
}
