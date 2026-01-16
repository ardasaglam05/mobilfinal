import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Güvenli Toplanma Alanları - Örnek verilerle
class SafeZonesScreen extends StatelessWidget {
  const SafeZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          '🗺️ Güvenli Toplanma Alanları',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bilgi kartı
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green.shade700, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Deprem sonrası bu alanlarda toplanın. Internet olmadan da görüntüleyebilirsiniz!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Toplanma alanları - İstanbul (25+ Gerçek Alan)
          
          // AVRUPA YAKASI - Merkezi Bölgeler
          _buildSafeZoneCard(
            context,
            name: 'Taksim Gezi Parkı',
            district: 'Beyoğlu / İstanbul',
            capacity: '50.000 kişi',
            distance: '1.2 km',
            latitude: 41.0369,
            longitude: 28.9850,
            facilities: ['İçme suyu', 'WC', 'Aydınlatma', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Maçka Demokrasi Parkı',
            district: 'Şişli / İstanbul',
            capacity: '30.000 kişi',
            distance: '2.5 km',
            latitude: 41.0466,
            longitude: 28.9949,
            facilities: ['İçme suyu', 'WC', 'Otopark'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Yıldız Parkı',
            district: 'Beşiktaş / İstanbul',
            capacity: '40.000 kişi',
            distance: '3.1 km',
            latitude: 41.0482,
            longitude: 29.0091,
            facilities: ['İçme suyu', 'WC', 'Geniş alan', 'Ağaçlık alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Abbasağa Parkı',
            district: 'Beşiktaş / İstanbul',
            capacity: '15.000 kişi',
            distance: '3.8 km',
            latitude: 41.0431,
            longitude: 28.9945,
            facilities: ['İçme suyu', 'Spor alanı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Emirgan Korusu',
            district: 'Sarıyer / İstanbul',
            capacity: '60.000 kişi',
            distance: '5.2 km',
            latitude: 41.1090,
            longitude: 29.0542,
            facilities: ['İçme suyu', 'WC', 'Geniş alan', 'Otopark', 'Ağaçlık alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Bebek Parkı',
            district: 'Beşiktaş / İstanbul',
            capacity: '20.000 kişi',
            distance: '4.2 km',
            latitude: 41.0783,
            longitude: 29.0431,
            facilities: ['İçme suyu', 'Sahil', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Gülhane Parkı',
            district: 'Fatih / İstanbul',
            capacity: '35.000 kişi',
            distance: '2.8 km',
            latitude: 41.0134,
            longitude: 28.9810,
            facilities: ['İçme suyu', 'WC', 'Tarihi alan', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Atatürk Orman Çiftliği (AOÇ) İstanbul',
            district: 'Sarıyer / İstanbul',
            capacity: '100.000 kişi',
            distance: '8.5 km',
            latitude: 41.1533,
            longitude: 28.9897,
            facilities: ['İçme suyu', 'WC', 'Geniş alan', 'Otopark'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Belgrad Ormanı',
            district: 'Sarıyer / İstanbul',
            capacity: '80.000 kişi',
            distance: '12 km',
            latitude: 41.1878,
            longitude: 28.9542,
            facilities: ['İçme suyu', 'Doğal alan', 'Geniş alan'],
          ),
          
          // AVRUPA YAKASI - Batı Bölgeler
          _buildSafeZoneCard(
            context,
            name: 'Atatürk Havalimanı Açık Alanı',
            district: 'Arnavutköy / İstanbul',
            capacity: '150.000 kişi',
            distance: '22 km',
            latitude: 40.9769,
            longitude: 28.8146,
            facilities: ['Geniş alan', 'Otopark', 'Aydınlatma'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Küçükçekmece Gölü Parkı',
            district: 'Küçükçekmece / İstanbul',
            capacity: '45.000 kişi',
            distance: '18 km',
            latitude: 41.0023,
            longitude: 28.7583,
            facilities: ['İçme suyu', 'WC', 'Göl kenarı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Florya Atatürk Ormanı',
            district: 'Bakırköy / İstanbul',
            capacity: '55.000 kişi',
            distance: '16 km',
            latitude: 40.9758,
            longitude: 28.7926,
            facilities: ['İçme suyu', 'WC', 'Sahil', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Yeşilköy Sahili',
            district: 'Bakırköy / İstanbul',
            capacity: '30.000 kişi',
            distance: '14 km',
            latitude: 40.9669,
            longitude: 28.8147,
            facilities: ['Sahil', 'Geniş alan', 'Otopark'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Bahçeşehir Gölet Parkı',
            district: 'Başakşehir / İstanbul',
            capacity: '40.000 kişi',
            distance: '24 km',
            latitude: 41.0331,
            longitude: 28.8094,
            facilities: ['İçme suyu', 'WC', 'Gölet', 'Geniş alan'],
          ),
          
          // ANADOLU YAKASI - Merkezi Bölgeler
          _buildSafeZoneCard(
            context,
            name: 'Fenerbahçe Parkı',
            district: 'Kadıköy / İstanbul',
            capacity: '35.000 kişi',
            distance: '6.5 km',
            latitude: 40.9640,
            longitude: 29.0364,
            facilities: ['İçme suyu', 'WC', 'Sahil', 'Spor alanı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Göztepe 60. Yıl Parkı',
            district: 'Kadıköy / İstanbul',
            capacity: '25.000 kişi',
            distance: '8 km',
            latitude: 40.9789,
            longitude: 29.0614,
            facilities: ['İçme suyu', 'WC', 'Spor alanı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Validebağ Korusu',
            district: 'Üsküdar / İstanbul',
            capacity: '30.000 kişi',
            distance: '7.2 km',
            latitude: 41.0131,
            longitude: 29.0542,
            facilities: ['İçme suyu', 'Doğal alan', 'Ağaçlık alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Fethi Paşa Korusu',
            district: 'Üsküdar / İstanbul',
            capacity: '35.000 kişi',
            distance: '9 km',
            latitude: 41.0175,
            longitude: 29.0753,
            facilities: ['İçme suyu', 'Doğal alan', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Çamlıca Tepesi Parkı',
            district: 'Üsküdar / İstanbul',
            capacity: '50.000 kişi',
            distance: '11 km',
            latitude: 41.0219,
            longitude: 29.0686,
            facilities: ['İçme suyu', 'WC', 'Panoramik alan', 'Otopark'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Polonezköy Tabiat Parkı',
            district: 'Beykoz / İstanbul',
            capacity: '40.000 kişi',
            distance: '28 km',
            latitude: 41.1628,
            longitude: 29.1931,
            facilities: ['İçme suyu', 'WC', 'Doğal alan', 'Orman'],
          ),
          
          // ANADOLU YAKASI - Doğu Bölgeler
          _buildSafeZoneCard(
            context,
            name: 'Aydos Ormanı',
            district: 'Pendik / İstanbul',
            capacity: '70.000 kişi',
            distance: '32 km',
            latitude: 40.9344,
            longitude: 29.2686,
            facilities: ['İçme suyu', 'Doğal alan', 'Orman', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Maltepe Sahil Parkı',
            district: 'Maltepe / İstanbul',
            capacity: '45.000 kişi',
            distance: '14 km',
            latitude: 40.9281,
            longitude: 29.1406,
            facilities: ['İçme suyu', 'WC', 'Sahil', 'Spor alanı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Kartal Sahil Parkı',
            district: 'Kartal / İstanbul',
            capacity: '40.000 kişi',
            distance: '18 km',
            latitude: 40.9022,
            longitude: 29.1822,
            facilities: ['İçme suyu', 'WC', 'Sahil', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Sancaktepe Millet Bahçesi',
            district: 'Sancaktepe / İstanbul',
            capacity: '55.000 kişi',
            distance: '25 km',
            latitude: 41.0025,
            longitude: 29.2236,
            facilities: ['İçme suyu', 'WC', 'Geniş alan', 'Spor alanı'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Dragos Sahili',
            district: 'Kartal / İstanbul',
            capacity: '25.000 kişi',
            distance: '20 km',
            latitude: 40.9136,
            longitude: 29.0753,
            facilities: ['Sahil', 'Geniş alan'],
          ),
          
          _buildSafeZoneCard(
            context,
            name: 'Çekmeköy Millet Bahçesi',
            district: 'Çekmeköy / İstanbul',
            capacity: '50.000 kişi',
            distance: '30 km',
            latitude: 41.0369,
            longitude: 29.2203,
            facilities: ['İçme suyu', 'WC', 'Geniş alan', 'Otopark'],
          ),
          
          const SizedBox(height: 20),
          
          // Not
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'İpuçları',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTip('Deprem öncesi en yakın toplanma alanını öğrenin'),
                _buildTip('Ailenizle toplanma noktasını önceden belirleyin'),
                _buildTip('Toplanma alanına giderken yıkık binalara yaklaşmayın'),
                _buildTip('Yanınıza su ve ilk yardım çantası alın'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafeZoneCard(
    BuildContext context, {
    required String name,
    required String district,
    required String capacity,
    required String distance,
    required double latitude,
    required double longitude,
    required List<String> facilities,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.park,
                    color: Colors.green.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        district,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    distance,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Kapasite
            Row(
              children: [
                Icon(Icons.groups, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  'Kapasite: $capacity',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Olanaklar
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: facilities.map((facility) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    facility,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green.shade900,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Haritada göster butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openInMaps(context, latitude, longitude, name),
                icon: const Icon(Icons.map, size: 20),
                label: const Text('HARITADA GÖSTER VE ROTA ÇİZ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 18, color: Colors.orange.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.orange.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openInMaps(
    BuildContext context,
    double latitude,
    double longitude,
    String name,
  ) async {
    // Google Maps linki oluştur
    final mapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=walking',
    );
    
    try {
      if (await canLaunchUrl(mapsUrl)) {
        await launchUrl(mapsUrl, mode: LaunchMode.externalApplication);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name için rota açılıyor...'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        throw 'Harita açılamadı';
      }
    } catch (e) {
      debugPrint('❌ Harita hatası: $e');
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: Harita açılamadı. $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
