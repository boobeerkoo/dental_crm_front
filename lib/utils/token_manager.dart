// import 'package:shared_preferences/shared_preferences.dart';

// class TokenManager {
//   static const String _tokenKey = 'jwt_token';
//   static const String _loggedOutKey =
//       'logged_out'; // New key for logged out flag

//   static Future<void> saveToken(String? token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token ?? '');
//   }

//   static Future<String> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey) ?? '';
//   }

//   static Future<void> removeToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_tokenKey);
//   }

//   static Future<void> setLoggedOut() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_loggedOutKey, true);
//   }

//   static Future<bool> getLoggedOut() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_loggedOutKey) ?? false;
//   }

//   static Future<void> clearLoggedOut() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_loggedOutKey);
//   }
// }
