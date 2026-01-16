import 'dart:convert';
import 'package:http/http.dart' as http;
import '../database/database_helper.dart';

/// Deprem modeli
class Earthquake {
  final String? earthquakeId;
  final String title;
  final String date;
  final String time;
  final double latitude;
  final double longitude;
  final double depth;
  final double magnitude;
  final String location;

  Earthquake({
    this.earthquakeId,
    required this.title,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.depth,
    required this.magnitude,
    required this.location,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    // date_time formatı: "2026-01-07 16:31:11"
    final dateTime = json['date_time'] ?? '';
    final parts = dateTime.split(' ');
    final date = parts.isNotEmpty ? parts[0] : '';
    final time = parts.length > 1 ? parts[1] : '';
    
    return Earthquake(
      earthquakeId: json['earthquake_id'],
      title: json['title'] ?? '',
      date: date,
      time: time,
      latitude: double.tryParse(json['geojson']?['coordinates']?[1]?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['geojson']?['coordinates']?[0]?.toString() ?? '0') ?? 0.0,
      depth: double.tryParse(json['depth']?.toString() ?? '0') ?? 0.0,
      magnitude: double.tryParse(json['mag']?.toString() ?? '0') ?? 0.0,
      location: json['title'] ?? 'Bilinmiyor',
    );
  }

  /// Veritabanından yükle
  factory Earthquake.fromDatabase(Map<String, dynamic> db) {
    final dateTime = db['date_time'] ?? '';
    final parts = dateTime.split(' ');
    final date = parts.isNotEmpty ? parts[0] : '';
    final time = parts.length > 1 ? parts[1] : '';

    return Earthquake(
      earthquakeId: db['earthquake_id'],
      title: db['title'] ?? '',
      date: date,
      time: time,
      latitude: db['latitude'] ?? 0.0,
      longitude: db['longitude'] ?? 0.0,
      depth: db['depth'] ?? 0.0,
      magnitude: db['magnitude'] ?? 0.0,
      location: db['location'] ?? 'Bilinmiyor',
    );
  }

  /// Veritabanına kaydet için Map'e çevir
  Map<String, dynamic> toDatabase() {
    return {
      'earthquake_id': earthquakeId,
      'title': title,
      'magnitude': magnitude,
      'location': location,
      'depth': depth,
      'latitude': latitude,
      'longitude': longitude,
      'date_time': '$date $time',
      'saved_at': DateTime.now().toIso8601String(),
    };
  }
}

/// Deprem servisi - Kandilli API'den veri çeker ve veritabanına kaydeder
class EarthquakeService {
  static const String apiUrl = 'https://api.orhanaydogdu.com.tr/deprem/kandilli/live';
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Son 10 depremi API'den getir ve veritabanına kaydet
  Future<List<Earthquake>> getRecentEarthquakes({bool saveToDb = true}) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> result = data['result'] ?? [];
        
        // İlk 10 depremi al
        final earthquakes = result
            .take(10)
            .map((json) => Earthquake.fromJson(json))
            .toList();

        // Veritabanına kaydet
        if (saveToDb) {
          for (var earthquake in earthquakes) {
            try {
              await _dbHelper.insertEarthquake(earthquake.toDatabase());
            } catch (e) {
              // Duplicate hatası görmezden gel
            }
          }
        }

        return earthquakes;
      } else {
        throw Exception('Deprem verileri yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  /// Veritabanından depremleri getir
  Future<List<Earthquake>> getEarthquakesFromDatabase({int? limit}) async {
    final dbEarthquakes = limit != null
        ? await _dbHelper.getRecentEarthquakes(limit)
        : await _dbHelper.getAllEarthquakes();

    return dbEarthquakes.map((db) => Earthquake.fromDatabase(db)).toList();
  }

  /// Belirli büyüklükteki depremleri getir
  Future<List<Earthquake>> getEarthquakesByMagnitude(double minMagnitude) async {
    final dbEarthquakes = await _dbHelper.getEarthquakesByMagnitude(minMagnitude);
    return dbEarthquakes.map((db) => Earthquake.fromDatabase(db)).toList();
  }

  /// Deprem kaydet
  Future<void> saveEarthquake(Earthquake earthquake) async {
    await _dbHelper.insertEarthquake(earthquake.toDatabase());
  }

  /// Tüm depremleri sil
  Future<void> clearAllEarthquakes() async {
    await _dbHelper.deleteAllEarthquakes();
  }
}
