import 'package:flutter/material.dart';

class ProviderUserType extends ChangeNotifier {
  String? userTypeProvider;

  void changeUserType(String changeUser) {
    userTypeProvider = changeUser;
    notifyListeners();
  }
}
