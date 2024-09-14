import 'package:alg_bucket/core/domain/algorithm.dart';
import 'package:alg_bucket/core/domain/algset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_core/cube_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../env.dart';

abstract interface class FirebaseStorageService {
  static FirebaseStorageService get instance =>
      isDev ? MockFirebaseStorageService._instance : FirebaseStorageServiceImpl._instance;

  Future<List<Algset>> getUserAlgsets();

  Future<void> addAlgset(Algset algset);

  Future<void> updateAlgset(Algset algset);
}

class FirebaseStorageServiceImpl implements FirebaseStorageService {
  FirebaseStorageServiceImpl._internal();

  static final FirebaseStorageService _instance = FirebaseStorageServiceImpl._internal();

  final db = FirebaseFirestore.instance;

  @override
  Future<List<Algset>> getUserAlgsets() async {
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
    return algsets;
  }

  @override
  Future<void> addAlgset(Algset algset) {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    final map = <String, dynamic>{
      'owner': id,
    };
    map.addAll(algset.toJson());

    return db.collection('algset').add(
          map,
        );
  }

  @override
  Future<void> updateAlgset(Algset algset) async {
    await db.collection('algset').doc(algset.id).update(algset.toJson());
  }
}

class MockFirebaseStorageService extends FirebaseStorageService {
  MockFirebaseStorageService._internal();

  static final MockFirebaseStorageService _instance = MockFirebaseStorageService._internal();

  final _algsets = [
    const Algset(
      id: '1',
      name: 'Mock Algset',
      cases: [],
      imageSetup: [
        CM.R,
        CM.U,
        CM.Ri,
        CM.Ui,
      ],
    ),
    const Algset(
      id: '1a',
      parentId: '1',
      name: 'Mock sub algset',
      cases: [
        Algorithm(
          name: 'Mock Algorithm',
          setup: [
            CM.R,
            CM.U,
            CM.Ri,
            CM.Ui,
          ],
          main: [
            CM.U,
            CM.R,
            CM.Ui,
            CM.Ri,
          ],
          alts: [
            [
              CM.R,
              CM.U,
              CM.Ri,
              CM.Ui,
            ],
            [
              CM.U,
              CM.R,
              CM.Ui,
              CM.Ri,
            ],
          ],
        ),
      ],
      imageSetup: [
        CM.R,
        CM.U,
        CM.Ri,
        CM.Ui,
      ],
    ),
    const Algset(
      id: '2',
      name: 'Mock Algset 2',
      cases: [],
      imageSetup: [
        CM.Ri,
        CM.F,
        CM.R,
        CM.Fi,
      ],
    ),
    const Algset(
      id: '3',
      name: 'Mock Algset 3',
      cases: [],
      imageSetup: [
        CM.M,
        CM.U,
        CM.Mi,
        CM.Ui,
      ],
    ),
  ];

  @override
  Future<List<Algset>> getUserAlgsets() async {
    return _algsets;
  }

  @override
  Future<void> addAlgset(Algset algset) {
    _algsets.add(algset);
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateAlgset(Algset algset) {
    final index = _algsets.indexWhere((element) => element.id == algset.id);
    _algsets[index] = algset;

    return Future.delayed(const Duration(seconds: 1));
  }
}
