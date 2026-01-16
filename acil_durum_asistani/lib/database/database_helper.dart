// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// SQLite Veritabanı Yöneticisi
/// Offline veri saklama için kullanılır
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('acil_durum.db');
    return _database!;
  }

  /// Veritabanını başlat
  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    } catch (e) {
      // Hata durumunda in-memory database kullan
      print('Database path error: $e. Using in-memory database.');
      return await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: _createDB,
      );
    }
  }

  /// Tabloları oluştur
  Future<void> _createDB(Database db, int version) async {
    // Yakınlar tablosu
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL UNIQUE,
        created_at TEXT NOT NULL
      )
    ''');

    // Güvendeyim kayıtları tablosu
    await db.execute('''
      CREATE TABLE safe_status (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        message TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        sent_to TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Deprem geçmişi tablosu
    await db.execute('''
      CREATE TABLE earthquakes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        earthquake_id TEXT UNIQUE,
        title TEXT NOT NULL,
        magnitude REAL NOT NULL,
        location TEXT NOT NULL,
        depth REAL NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        date_time TEXT NOT NULL,
        saved_at TEXT NOT NULL
      )
    ''');
  }

  // ==================== CONTACTS (Yakınlar) ====================

  /// Yakın ekle
  Future<int> insertContact(Map<String, dynamic> contact) async {
    final db = await database;
    return await db.insert('contacts', contact);
  }

  /// Tüm yakınları getir
  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final db = await database;
    return await db.query('contacts', orderBy: 'created_at DESC');
  }

  /// Yakın sil
  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  /// Telefon numarasına göre yakın bul
  Future<Map<String, dynamic>?> getContactByPhone(String phone) async {
    final db = await database;
    final results = await db.query(
      'contacts',
      where: 'phone = ?',
      whereArgs: [phone],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // ==================== SAFE STATUS (Güvendeyim) ====================

  /// Güvendeyim kaydı ekle
  Future<int> insertSafeStatus(Map<String, dynamic> status) async {
    final db = await database;
    return await db.insert('safe_status', status);
  }

  /// Tüm güvendeyim kayıtlarını getir
  Future<List<Map<String, dynamic>>> getAllSafeStatus() async {
    final db = await database;
    return await db.query('safe_status', orderBy: 'timestamp DESC');
  }

  /// Son güvendeyim kaydını getir
  Future<Map<String, dynamic>?> getLastSafeStatus() async {
    final db = await database;
    final results = await db.query(
      'safe_status',
      orderBy: 'timestamp DESC',
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  // ==================== EARTHQUAKES (Depremler) ====================

  /// Deprem kaydı ekle
  Future<int> insertEarthquake(Map<String, dynamic> earthquake) async {
    final db = await database;
    try {
      return await db.insert('earthquakes', earthquake);
    } catch (e) {
      // Duplicate earthquake_id durumunda güncelle
      return await db.update(
        'earthquakes',
        earthquake,
        where: 'earthquake_id = ?',
        whereArgs: [earthquake['earthquake_id']],
      );
    }
  }

  /// Tüm depremleri getir
  Future<List<Map<String, dynamic>>> getAllEarthquakes() async {
    final db = await database;
    return await db.query('earthquakes', orderBy: 'date_time DESC');
  }

  /// Belirli büyüklükteki depremleri getir
  Future<List<Map<String, dynamic>>> getEarthquakesByMagnitude(
      double minMagnitude) async {
    final db = await database;
    return await db.query(
      'earthquakes',
      where: 'magnitude >= ?',
      whereArgs: [minMagnitude],
      orderBy: 'date_time DESC',
    );
  }

  /// Son N depremi getir
  Future<List<Map<String, dynamic>>> getRecentEarthquakes(int limit) async {
    final db = await database;
    return await db.query(
      'earthquakes',
      orderBy: 'saved_at DESC',
      limit: limit,
    );
  }

  /// Deprem sil
  Future<int> deleteEarthquake(int id) async {
    final db = await database;
    return await db.delete('earthquakes', where: 'id = ?', whereArgs: [id]);
  }

  /// Tüm depremleri sil
  Future<int> deleteAllEarthquakes() async {
    final db = await database;
    return await db.delete('earthquakes');
  }

  // ==================== GENEL ====================

  /// Veritabanını kapat
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  /// Veritabanı istatistikleri
  Future<Map<String, int>> getStats() async {
    final db = await database;
    
    final contactsCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM contacts'),
    ) ?? 0;
    
    final safeStatusCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM safe_status'),
    ) ?? 0;
    
    final earthquakesCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM earthquakes'),
    ) ?? 0;

    return {
      'contacts': contactsCount,
      'safe_status': safeStatusCount,
      'earthquakes': earthquakesCount,
    };
  }
}
