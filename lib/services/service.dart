import 'package:shared_preferences/shared_preferences.dart';

void saveUserId(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("userId", id);
}

Future<int> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt("userId") != null) {
    return prefs.getInt("userId")!;
  } else {
    return 0;
  }
}

void logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("userId", 0);
}
