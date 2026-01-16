import 'package:intl/intl.dart';

/// Mesaj oluşturma servisi
/// Offline çalışır, tarih/saat formatlar
class MessageService {
  /// Güvendeyim mesajı oluştur
  /// [location] - Opsiyonel konum bilgisi (latitude, longitude)
  /// [batteryLevel] - Opsiyonel batarya seviyesi (0-100)
  String createSafeMessage(
    DateTime time, {
    Map<String, double>? location,
    int? batteryLevel,
  }) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');
    
    final date = dateFormat.format(time);
    final timeStr = timeFormat.format(time);
    
    // Temel mesaj
    StringBuffer message = StringBuffer('Ben güvendeyim.\n');
    message.write('Tarih: $date\n');
    message.write('Saat: $timeStr');
    
    // Konum bilgisi varsa ekle
    if (location != null && location.containsKey('latitude') && location.containsKey('longitude')) {
      final lat = location['latitude']!;
      final lng = location['longitude']!;
      
      // Google Maps linki oluştur
      final mapsUrl = 'https://maps.google.com/?q=$lat,$lng';
      message.write('\n\nKonumum: $mapsUrl');
    }
    
    // Batarya bilgisi varsa ekle
    if (batteryLevel != null) {
      message.write('\n\nBataryam: %$batteryLevel');
      
      // Düşük batarya uyarısı
      if (batteryLevel <= 20) {
        message.write(', telefonum kapanabilir');
      }
    }
    
    return message.toString();
  }


  /// Acil durum mesajı oluştur
  /// [location] - Opsiyonel konum bilgisi (latitude, longitude)
  /// [batteryLevel] - Opsiyonel batarya seviyesi (0-100)
  String createEmergencyMessage(
    DateTime time, {
    Map<String, double>? location,
    int? batteryLevel,
  }) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');
    
    final date = dateFormat.format(time);
    final timeStr = timeFormat.format(time);
    
    // Acil durum mesajı
    StringBuffer message = StringBuffer('🆘 ACİL DURUM! 🆘\n');
    message.write('YARDIM EDİN!\n\n');
    message.write('Tarih: $date\n');
    message.write('Saat: $timeStr');
    
    // Konum bilgisi varsa ekle
    if (location != null && location.containsKey('latitude') && location.containsKey('longitude')) {
      final lat = location['latitude']!;
      final lng = location['longitude']!;
      
      // Google Maps linki oluştur
      final mapsUrl = 'https://maps.google.com/?q=$lat,$lng';
      message.write('\n\nKonumum: $mapsUrl');
    }
    
    // Batarya bilgisi varsa ekle
    if (batteryLevel != null) {
      message.write('\n\nBataryam: %$batteryLevel');
      
      // Düşük batarya uyarısı
      if (batteryLevel <= 20) {
        message.write(', telefonum kapanabilir');
      }
    }
    
    message.write('\n\nLÜTFEN HEMEN YARDIM GÖNDERİN!');
    
    return message.toString();
  }


  /// Tarih/saat formatla (görüntüleme için)
  String formatDateTime(DateTime time) {
    final format = DateFormat('dd.MM.yyyy HH:mm');
    return format.format(time);
  }
}
