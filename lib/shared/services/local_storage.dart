import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // mengambil instance SharedPreferences shared preference
  Future<SharedPreferences> get _prefs {
    return SharedPreferences.getInstance();
  }


  // menyimpan data berdasarkan storage key ke shared preference
  Future<void> save(String storageKey, String value) async {
    final prefs = await _prefs;

    await prefs.setString(
      storageKey,
      value,
    );
  }


  // mengambil data berdasarkan storage key dari shared preference
  Future<String?> get(String storageKey) async {
    final prefs = await _prefs;

    return prefs.getString(storageKey);
  }


  //  menghapus data berdasarkan storage key dari shared preference
  Future<void> delete(String storageKey) async {
    final prefs = await _prefs;

    await prefs.remove(storageKey);
  }
}