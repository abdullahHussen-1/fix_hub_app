// todo include 3 functions Shared prferences [set tocken -- get tocken -- clear tocken ]
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tockenKey = 'auth_tocken';
  // todo future function use to save tocken 
  static Future<void> saveTocken(String tocken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tockenKey, tocken);
  }
 // todo future function use to get tocken 
  static Future<String?> getTocken() async {
    final prefs = await SharedPreferences.getInstance();
   return prefs.getString(_tockenKey);
  }
   // todo future function use to remove tocken like logout 
  static Future<void> clerTocken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tockenKey);
  }
}
