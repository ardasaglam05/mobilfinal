// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/earthquake_service.dart';
import 'first_aid_screen.dart';
import 'safe_zones_screen.dart';

/// Deprem ekranı - Yapılacaklar listesi ve canlı deprem verileri
class EarthquakeScreen extends StatefulWidget {
  const EarthquakeScreen({super.key});

  @override
  State<EarthquakeScreen> createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  final EarthquakeService _earthquakeService = EarthquakeService();
  List<Earthquake> _earthquakes = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEarthquakes();
  }

  /// Deprem verilerini yükle
  Future<void> _loadEarthquakes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final earthquakes = await _earthquakeService.getRecentEarthquakes();
      setState(() {
        _earthquakes = earthquakes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Deprem Bilgileri',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadEarthquakes,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hızlı Erişim Butonları
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FirstAidScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.medical_services, size: 20),
                      label: const Text(
                        'İlk Yardım\nRehberi',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SafeZonesScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.location_on, size: 20),
                      label: const Text(
                        'Toplanma\nAlanları',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Deprem Anında Yapılacaklar
            _buildEmergencyTasks(),
            
            const SizedBox(height: 20),
            
            // Canlı Deprem Verileri
            _buildEarthquakeData(),
          ],
        ),
      ),
    );
  }

  /// Deprem anında yapılacaklar listesi
  Widget _buildEmergencyTasks() {
    final tasks = [
      {'icon': Icons.person_off, 'title': 'ÇÖK-KAPAN-TUTUN', 'desc': 'Masanın altına gir, başını koru'},
      {'icon': Icons.door_back_door, 'title': 'Kapılardan Uzak Dur', 'desc': 'Kapı çerçevesi güvenli değil'},
      {'icon': Icons.window, 'title': 'Camlardan Uzaklaş', 'desc': 'Kırılabilir, yaralanabilirsin'},
      {'icon': Icons.elevator, 'title': 'Asansör Kullanma', 'desc': 'Merdivenleri tercih et'},
      {'icon': Icons.local_fire_department, 'title': 'Doğalgaz Kapat', 'desc': 'Yangın riskini önle'},
      {'icon': Icons.flashlight_on, 'title': 'Fener Kullan', 'desc': 'Kibrit/çakmak yangın riski'},
      {'icon': Icons.phone, 'title': 'Acil Hatları Meşgul Etme', 'desc': '112 sadece acil durumda'},
      {'icon': Icons.exit_to_app, 'title': 'Sakin Çık', 'desc': 'Sarsıntı bittikten sonra dışarı'},
      {'icon': Icons.location_on, 'title': 'Toplanma Alanına Git', 'desc': 'Önceden belirlenen alana'},
      {'icon': Icons.people, 'title': 'Yakınlarını Bilgilendir', 'desc': 'Güvendeyim mesajı gönder'},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 28),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'DEPREM ANINDA YAPILACAKLAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Görev listesi
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade100,
                  child: Icon(
                    task['icon'] as IconData,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                ),
                title: Text(
                  task['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  task['desc'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                dense: true,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Canlı deprem verileri
  Widget _buildEarthquakeData() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.public, color: Colors.red.shade700, size: 28),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'SON DEPREMLER (Kandilli)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // İçerik
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                  const SizedBox(height: 12),
                  Text(
                    'Veriler yüklenemedi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loadEarthquakes,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Dene'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          else if (_earthquakes.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Text(
                  'Deprem verisi bulunamadı',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _earthquakes.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                final eq = _earthquakes[index];
                final magnitudeColor = _getMagnitudeColor(eq.magnitude);
                
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: magnitudeColor.withOpacity(0.2),
                    child: Text(
                      eq.magnitude.toStringAsFixed(1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: magnitudeColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  title: Text(
                    eq.location,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            '${eq.date} ${eq.time}',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.layers, size: 12, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            'Derinlik: ${eq.depth.toStringAsFixed(1)} km',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                  ),
                  dense: true,
                  onTap: () => _showEarthquakeDetails(eq),
                );
              },
            ),
        ],
      ),
    );
  }

  /// Büyüklüğe göre renk
  Color _getMagnitudeColor(double magnitude) {
    if (magnitude >= 5.0) return Colors.red;
    if (magnitude >= 4.0) return Colors.orange;
    if (magnitude >= 3.0) return Colors.amber;
    return Colors.green;
  }

  /// Deprem detayları dialog
  void _showEarthquakeDetails(Earthquake eq) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.public, color: Colors.red.shade700),
            const SizedBox(width: 8),
            const Expanded(child: Text('Deprem Detayı')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Büyüklük', '${eq.magnitude.toStringAsFixed(1)} ML'),
            _buildDetailRow('Konum', eq.location),
            _buildDetailRow('Tarih', eq.date),
            _buildDetailRow('Saat', eq.time),
            _buildDetailRow('Derinlik', '${eq.depth.toStringAsFixed(1)} km'),
            _buildDetailRow('Enlem', eq.latitude.toStringAsFixed(4)),
            _buildDetailRow('Boylam', eq.longitude.toStringAsFixed(4)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('KAPAT'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
