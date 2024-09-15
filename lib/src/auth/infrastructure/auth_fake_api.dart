import 'package:alg_bucket/src/auth/domain/auth_api_interface.dart';
import 'package:alg_bucket/src/auth/domain/user_data.dart';
import 'package:alg_bucket/src/shared/domain/fake_response.dart';
import 'package:alg_bucket/src/shared/domain/maybe.dart';
import 'package:dartz/dartz.dart';

class AuthFakeApi implements AuthApiInterface {
  @override
  Future<Maybe<Unit>> logOut() {
    return FakeResponse.success(unit);
  }

  @override
  Future<Maybe<UserData>> signInWithGoogle() {
    return FakeResponse.success(const UserData(displayName: 'Fake User', email: 'John.doe@fake.com'));
  }

  @override
  Future<Maybe<UserData>> signSilently() {
    return FakeResponse.error();
  }
}
