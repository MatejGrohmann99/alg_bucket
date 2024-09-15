import 'package:alg_bucket/src/shared/domain/environment.dart';
import 'package:dartz/dartz.dart';

import '../infrastructure/algset_fake_api.dart';
import '../infrastructure/algset_impl_api.dart';
import 'algset.dart';
import '../../shared/domain/maybe.dart';

AlgsetApiInterface _instance = kIsDev ? AlgsetFakeApi() : AlgsetImplApi();

abstract interface class AlgsetApiInterface {
  static AlgsetApiInterface get instance => _instance;

  Future<Maybe<List<Algset>>> getUserAlgsets();

  Future<Maybe<Unit>> addAlgset(Algset algset);

  Future<Maybe<Unit>> updateAlgset(Algset algset);
}
