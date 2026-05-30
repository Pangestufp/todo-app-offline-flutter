import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Mengambil instance SharedPreferences.
  Future<SharedPreferences> get _prefs {
    return SharedPreferences.getInstance();
  }

  // Menyimpan data berdasarkan storage key.
  Future<void> save(String storageKey, String value) async {
    final prefs = await _prefs;

    await prefs.setString(
      storageKey,
      value,
    );
  }

  // Mengambil data berdasarkan storage key.
  Future<String?> get(String storageKey) async {
    final prefs = await _prefs;

    return prefs.getString(storageKey);
  }

  // Menghapus data berdasarkan storage key.
  Future<void> delete(String storageKey) async {
    final prefs = await _prefs;

    await prefs.remove(storageKey);
  }
}