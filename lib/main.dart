import 'package:fix_hub/my_app.dart';
import 'package:fix_hub/provider/provider_user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProviderUserType())
    ],
    child: MyApp(),
  ));
}
