import '../database/database_helper.dart';

/// Yakınların telefon numaralarını yöneten servis
/// SQLite veritabanı kullanır (offline çalışır)
class ContactsService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Telefon numarası ekle (isim otomatik "Yakın" olarak kaydedilir)
  Future<void> addContact(String phoneNumber) async {
    // Aynı numara varsa ekleme
    final existing = await _dbHelper.getContactByPhone(phoneNumber);
    if (existing != null) {
      throw Exception('Bu numara zaten kayıtlı');
    }

    await _dbHelper.insertContact({
      'name': 'Yakın',
      'phone': phoneNumber,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  /// Tüm yakınları getir (veritabanından)
  Future<List<Map<String, dynamic>>> getContacts() async {
    return await _dbHelper.getAllContacts();
  }

  /// Sadece telefon numaralarını getir (eski API uyumluluğu için)
  Future<List<String>> getContactPhones() async {
    final contacts = await getContacts();
    return contacts.map((c) => c['phone'] as String).toList();
  }

  /// Telefon numarası sil
  Future<void> removeContact(int id) async {
    await _dbHelper.deleteContact(id);
  }

  /// Tüm numaraları temizle
  Future<void> clearAllContacts() async {
    final contacts = await getContacts();
    for (var contact in contacts) {
      await _dbHelper.deleteContact(contact['id'] as int);
    }
  }
}
