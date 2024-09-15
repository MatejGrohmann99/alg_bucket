import 'package:alg_bucket/src/algset/domain/algset.dart';
import 'package:alg_bucket/src/algset/domain/algset_api_interface.dart';
import 'package:alg_bucket/src/shared/domain/maybe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlgsetImplApi implements AlgsetApiInterface {
  final db = FirebaseFirestore.instance;

  @override
  Future<Maybe<List<Algset>>> getUserAlgsets() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    final col = db.collection('algset').where(
          'owner',
          isEqualTo: id,
        );
    final data = await col.get();

    final algsets = data.docs
        .map(
          (doc) {
            return Algset.fromJson(
              doc.id,
              doc.data(),
            );
          },
        )
        .nonNulls
        .toList();
    return Right(algsets);
  }

  @override
  Future<Maybe<Unit>> addAlgset(Algset algset) async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    final map = <String, dynamic>{
      'owner': id,
    };
    map.addAll(algset.toJson());

    await db.collection('algset').add(
          map,
        );

    return const Right(unit);
  }

  @override
  Future<Maybe<Unit>> updateAlgset(Algset algset) async {
    await db.collection('algset').doc(algset.id).update(algset.toJson());
    return const Right(unit);
  }
}
