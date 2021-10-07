import 'package:shared_preferences/shared_preferences.dart';
class Helper
{
  static SharedPreferences sharedPreferences ;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putString( String key, String value)
  {
    sharedPreferences.setString(key, value);
  }

  static String getString( String key)
  {
    return sharedPreferences.getString(key);
  }

  static putBoolean( String key, bool value)
  {
    sharedPreferences.setBool(key, value);
  }

  static bool getBoolean( String key)
  {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> remove( String key)
  {
    return sharedPreferences.remove(key);
  }
}