import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class FirebaseStorageService {
  FirebaseStorageService._internal();

  static final FirebaseStorageService _instance = FirebaseStorageService._internal();

  static FirebaseStorageService get instance => _instance;

  final db = FirebaseFirestore.instance;

  Query<Map<String, dynamic>> queryByCollectionAndCreator(String collectionId, String creatorId) => db
      .collection('algorithms')
      .where('collectionId', isEqualTo: collectionId)
      .where('creatorId', isEqualTo: creatorId);

  Query<Map<String, dynamic>> queryByCreator(String creatorId) =>
      db.collection('algorithms').where('creatorId', isEqualTo: creatorId);

  Future<void> getUserAlgCollection() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    print(id);
    final col = queryByCreator(id);
    final data = await col.get();

    print(data.size);
    print(data.docs);
  }
}
