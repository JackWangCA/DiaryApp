import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyMemoryImagePath = 'memoryImagePath';
  static const _keyMemoryName = 'memoryName';
  static const _keyMemoryDescription = 'memoryDescription';
  static const _keyMemoryCategory = 'memoryCategory';
  static const _keyMemoryLat = 'memoryLat';
  static const _keyMemoryLong = 'memoryLong';
  static const _keyMemoryCreatedTime = 'memoryCreatedTime';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setMemoryImagePath(String memoryImagePath) async =>
      await _preferences.setString(_keyMemoryImagePath, memoryImagePath);

  static String getMemoryImagePath() =>
      _preferences.getString(_keyMemoryImagePath);

  static Future setMemoryName(String memoryName) async =>
      await _preferences.setString(_keyMemoryName, memoryName);

  static String getMemoryName() => _preferences.getString(_keyMemoryName);

  static Future setMemoryDescription(String memoryDescription) async =>
      await _preferences.setString(_keyMemoryDescription, memoryDescription);

  static String getMemoryDescription() =>
      _preferences.getString(_keyMemoryDescription);

  static Future setMemoryCategory(String memoryCategory) async =>
      await _preferences.setString(_keyMemoryCategory, memoryCategory);

  static String getMemoryCategory() =>
      _preferences.getString(_keyMemoryCategory);

  static Future setMemoryLat(double memoryLat) async =>
      await _preferences.setDouble(_keyMemoryLat, memoryLat);

  static double getMemoryLat() => _preferences.getDouble(_keyMemoryLat);

  static Future setMemoryLong(double memoryLong) async =>
      await _preferences.setDouble(_keyMemoryLong, memoryLong);

  static double getMemoryLong() => _preferences.getDouble(_keyMemoryLong);

  static Future setMemoryCreatedTime(DateTime memoryCreatedTime) async {
    final time = memoryCreatedTime.toIso8601String();

    return await _preferences.setString(_keyMemoryCreatedTime, time);
  }

  static DateTime getMemoryCreatedTime() {
    final time = _preferences.getString(_keyMemoryCreatedTime);

    return time == null ? null : DateTime.tryParse(time);
  }
}
