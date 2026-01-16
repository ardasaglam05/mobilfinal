import '../database/database_helper.dart';

/// Güvendeyim durumunu yöneten servis
/// SQLite veritabanı kullanır (offline çalışır)
class SafeStatusService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Güvendeyim kaydı ekle
  Future<void> saveSafeStatus({
    required String message,
    required DateTime timestamp,
    List<String>? sentTo,
  }) async {
    await _dbHelper.insertSafeStatus({
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'sent_to': sentTo?.join(','),
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  /// Son güvendeyim zamanını getir
  Future<DateTime?> getSafeTime() async {
    final lastStatus = await _dbHelper.getLastSafeStatus();
    if (lastStatus == null) return null;

    try {
      return DateTime.parse(lastStatus['timestamp'] as String);
    } catch (e) {
      return null;
    }
  }

  /// Tüm güvendeyim kayıtlarını getir
  Future<List<Map<String, dynamic>>> getAllSafeStatus() async {
    return await _dbHelper.getAllSafeStatus();
  }

  /// Son güvendeyim kaydını getir
  Future<Map<String, dynamic>?> getLastSafeStatus() async {
    return await _dbHelper.getLastSafeStatus();
  }

  /// Güvendeyim kaydını temizle (eski API uyumluluğu için)
  Future<void> clearSafeTime() async {
    // SQLite'da silme yerine, yeni kayıt eklemeye devam ediyoruz
    // Geçmiş kayıtlar korunur
  }
}
