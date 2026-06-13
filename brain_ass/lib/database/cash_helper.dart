import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  // Initialize SharedPreferences
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Put data in cache storage
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is List<String>) return await sharedPreferences.setStringList(key, value);
    throw Exception("Type not supported");
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }


  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static bool containsData({required String key}) {
    return sharedPreferences.containsKey(key);
  }


  static Future<bool> clearAll() async {
    return await sharedPreferences.clear();
  }
}
