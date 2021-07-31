import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

/// 这个工具可以同步操作SharePreferences

class SharePreferencesUtils {
  static SharePreferencesUtils? _singleton;
  static SharedPreferences? _prefs;
  static Lock _lock = Lock();
 
  static Future<SharePreferencesUtils> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SharePreferencesUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }
 
  SharePreferencesUtils._();
 
  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getValue(String key) {
    if (_prefs == null) return null;
    var status = _prefs!.getString(key);
    if (status == null) return "";
    return status;
  }
  
  static Future<bool>? putValue(String key, String value) {
    if (_prefs == null) return null;
    return _prefs!.setString(key, value);
  }

  static void remove(String key) {
    if (_prefs == null) return;
    _prefs!.remove(key);
  }
}