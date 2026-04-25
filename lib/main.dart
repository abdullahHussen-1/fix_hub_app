import 'package:firebase_core/firebase_core.dart';
import 'package:fix_hub/my_app.dart';
import 'package:fix_hub/provider/provider_user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderUserType())
      ],
      child: MyApp(),
    ));
  } catch (error) {
    print("Firebase Error: $error");
  }
}
