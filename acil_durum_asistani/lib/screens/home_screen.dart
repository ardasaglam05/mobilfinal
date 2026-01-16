import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:battery_plus/battery_plus.dart';
import '../services/safe_status_service.dart';
import '../services/message_service.dart';
import 'safe_mode_screen.dart';
import 'contacts_screen.dart';
import 'earthquake_screen.dart';
import 'database_debug_screen.dart';

/// Ana ekran - 3 ana buton içerir
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SafeStatusService _safeStatusService = SafeStatusService();
  final MessageService _messageService = MessageService();
  String? _lastSafeTime;

  @override
  void initState() {
    super.initState();
    _loadLastSafeTime();
  }

  /// Son güvendeyim zamanını yükle
  Future<void> _loadLastSafeTime() async {
    final time = await _safeStatusService.getSafeTime();
    if (time != null) {
      setState(() {
        _lastSafeTime = _messageService.formatDateTime(time);
      });
    }
  }

  /// Deprem butonu - Deprem bilgileri ve yapılacaklar
  void _onEarthquakePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EarthquakeScreen(),
      ),
    );
  }

  /// Güvendeyim butonu
  void _onSafePressed() async {
    // Loading dialog göster
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Konum ve batarya bilgisi alınıyor...'),
              ],
            ),
          ),
        ),
      ),
    );
    
    final now = DateTime.now();
    Map<String, double>? location;
    int? batteryLevel;
    
    try {
      // 1️⃣ Konum bilgisini al
      location = await _getLocation();
      
      // 2️⃣ Batarya bilgisini al
      batteryLevel = await _getBatteryLevel();
      
    } catch (e) {
      debugPrint('⚠️ Konum/Batarya hatası: $e');
      // Hata olsa bile devam et, sadece o bilgi olmadan mesaj oluştur
    }
    
    // Loading dialog'u kapat
    if (mounted) {
      Navigator.of(context).pop();
    }
    
    // Mesaj oluştur (konum ve batarya bilgisiyle)
    final message = _messageService.createSafeMessage(
      now,
      location: location,
      batteryLevel: batteryLevel,
    );
    
    // Veritabanına kaydet
    await _safeStatusService.saveSafeStatus(
      message: message,
      timestamp: now,
    );
    
    // Konsola yazdır (test)
    debugPrint('🟢 GÜVENDEYİM mesajı oluşturuldu ve veritabanına kaydedildi:');
    debugPrint(message);
    if (location != null) {
      debugPrint('📍 Konum: ${location['latitude']}, ${location['longitude']}');
    }
    if (batteryLevel != null) {
      debugPrint('🔋 Batarya: %$batteryLevel');
    }
    
    // Safe Mode ekranına git
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SafeModeScreen(
            message: message,
            timestamp: now,
          ),
        ),
      ).then((_) => _loadLastSafeTime()); // Geri dönünce yenile
    }
  }
  
  /// Konum bilgisini al
  Future<Map<String, double>?> _getLocation() async {
    try {
      // Konum servisi açık mı kontrol et
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('⚠️ Konum servisi kapalı');
        return null;
      }
      
      // İzin kontrolü
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('⚠️ Konum izni reddedildi');
          return null;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        debugPrint('⚠️ Konum izni kalıcı olarak reddedildi');
        return null;
      }
      
      // Konum al (timeout: 10 saniye)
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      debugPrint('❌ Konum alma hatası: $e');
      return null;
    }
  }
  
  /// Batarya seviyesini al
  Future<int?> _getBatteryLevel() async {
    try {
      final battery = Battery();
      final level = await battery.batteryLevel;
      return level;
    } catch (e) {
      debugPrint('❌ Batarya bilgisi alma hatası: $e');
      return null;
    }
  }

  /// Yakınlar butonu
  void _onContactsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      ),
    );
  }

  /// Güvende Değilim butonu (Acil Durum)
  void _onEmergencyPressed() async {
    // Loading dialog göster
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.red),
                SizedBox(height: 16),
                Text('Acil durum mesajı hazırlanıyor...'),
              ],
            ),
          ),
        ),
      ),
    );
    
    final now = DateTime.now();
    Map<String, double>? location;
    int? batteryLevel;
    
    try {
      // 1️⃣ Konum bilgisini al
      location = await _getLocation();
      
      // 2️⃣ Batarya bilgisini al
      batteryLevel = await _getBatteryLevel();
      
    } catch (e) {
      debugPrint('⚠️ Konum/Batarya hatası: $e');
      // Hata olsa bile devam et, sadece o bilgi olmadan mesaj oluştur
    }
    
    // Loading dialog'u kapat
    if (mounted) {
      Navigator.of(context).pop();
    }
    
    // ACİL DURUM mesajı oluştur (konum ve batarya bilgisiyle)
    final message = _messageService.createEmergencyMessage(
      now,
      location: location,
      batteryLevel: batteryLevel,
    );
    
    // Konsola yazdır (test)
    debugPrint('🆘 ACİL DURUM mesajı oluşturuldu:');
    debugPrint(message);
    if (location != null) {
      debugPrint('📍 Konum: ${location['latitude']}, ${location['longitude']}');
    }
    if (batteryLevel != null) {
      debugPrint('🔋 Batarya: %$batteryLevel');
    }
    
    // Safe Mode ekranına git (Acil Durum modu ile)
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SafeModeScreen(
            message: message,
            timestamp: now,
            isEmergency: true, // Acil durum modu aktif
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Acil Durum Asistanı',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        actions: [
          // Debug butonu
          IconButton(
            icon: const Icon(Icons.storage, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DatabaseDebugScreen(),
                ),
              );
            },
            tooltip: 'Veritabanı Debug',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo / Başlık alanı
              const Icon(
                Icons.emergency,
                size: 80,
                color: Color(0xFFD32F2F),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Acil Durumda Yanınızdayız',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Son güvendeyim zamanı
              if (_lastSafeTime != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    'Son güvendeyim: $_lastSafeTime',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              
              const SizedBox(height: 40),
              
              // 1️⃣ DEPREM butonu
              _buildMainButton(
                icon: Icons.warning_amber_rounded,
                label: 'DEPREM',
                color: Colors.orange,
                onPressed: _onEarthquakePressed,
              ),
              
              const SizedBox(height: 20),
              
              // 2️⃣ GÜVENDEYİM butonu
              _buildMainButton(
                icon: Icons.check_circle,
                label: 'GÜVENDEYİM',
                color: Colors.green,
                onPressed: _onSafePressed,
              ),
              
              const SizedBox(height: 20),
              
              // 3️⃣ GÜVENDE DEĞİLİM butonu (Acil Durum)
              _buildMainButton(
                icon: Icons.warning,
                label: 'GÜVENDE DEĞİLİM',
                color: Colors.red.shade700,
                onPressed: _onEmergencyPressed,
              ),
              
              const SizedBox(height: 20),
              
              // 4️⃣ YAKINLAR butonu
              _buildMainButton(
                icon: Icons.people,
                label: 'YAKINLAR',
                color: Colors.blue,
                onPressed: _onContactsPressed,
              ),
              
              const SizedBox(height: 40),
              
              // Alt bilgi
              Text(
                'İnternet olmadan çalışır 📱',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Ana buton widget'ı
  Widget _buildMainButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
