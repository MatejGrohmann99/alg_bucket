import 'package:alg_bucket/firebase_options.dart';
import 'package:alg_bucket/presentation/web_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kIsWeb) {
    runApp(
      const WebApp(),
    );
  }
}
