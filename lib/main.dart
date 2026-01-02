import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensures Flutter engine is ready before async calls
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 REQUIRED: Initialize Firebase BEFORE using FirebaseAuth
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Start the app AFTER Firebase is ready
  runApp(const EstateBridgeApp());
}
