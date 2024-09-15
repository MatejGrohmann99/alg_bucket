import 'package:alg_bucket/src/shared/domain/environment.dart';
import 'package:alg_bucket/src/auth/domain/user_data.dart';
import 'package:alg_bucket/src/auth/infrastructure/auth_fake_api.dart';
import 'package:alg_bucket/src/auth/infrastructure/auth_impl_api.dart';
import 'package:dartz/dartz.dart';

import '../../shared/domain/maybe.dart';

AuthApiInterface _instance = kIsDev ? AuthFakeApi() : AuthImplApi();

abstract interface class AuthApiInterface {
  static AuthApiInterface get instance => _instance;

  Future<Maybe<UserData>> signInWithGoogle();

  Future<Maybe<UserData>> signSilently();

  Future<Maybe<Unit>> logOut();
}
