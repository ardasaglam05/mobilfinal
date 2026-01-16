import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../services/contacts_service.dart';
import '../services/safe_status_service.dart';
import '../services/earthquake_service.dart';

/// Veritabanı Debug/İstatistik Ekranı
/// Veritabanı içeriğini görüntüler ve test eder
class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final ContactsService _contactsService = ContactsService();
  final SafeStatusService _safeStatusService = SafeStatusService();
  final EarthquakeService _earthquakeService = EarthquakeService();

  Map<String, int> _stats = {};
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _safeStatus = [];
  List<Map<String, dynamic>> _earthquakes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final stats = await _dbHelper.getStats();
      final contacts = await _contactsService.getContacts();
      final safeStatus = await _safeStatusService.getAllSafeStatus();
      final earthquakes = await _earthquakeService.getEarthquakesFromDatabase(limit: 10);

      setState(() {
        _stats = stats;
        _contacts = contacts;
        _safeStatus = safeStatus;
        _earthquakes = earthquakes.map((e) => {
          'title': e.title,
          'magnitude': e.magnitude,
          'date_time': '${e.date} ${e.time}',
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showMessage('Hata: $e', isError: true);
    }
  }

  Future<void> _addTestData() async {
    try {
      // Test yakını ekle
      await _contactsService.addContact('05551234567');
      
      // Test güvendeyim kaydı ekle
      await _safeStatusService.saveSafeStatus(
        message: 'Test mesajı',
        timestamp: DateTime.now(),
      );

      _showMessage('✓ Test verileri eklendi');
      _loadData();
    } catch (e) {
      _showMessage('Hata: $e', isError: true);
    }
  }

  Future<void> _clearDatabase() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Veritabanını Temizle'),
        content: const Text('Tüm verileri silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İPTAL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('SİL'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _contactsService.clearAllContacts();
        await _earthquakeService.clearAllEarthquakes();
        _showMessage('✓ Veritabanı temizlendi');
        _loadData();
      } catch (e) {
        _showMessage('Hata: $e', isError: true);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Veritabanı Debug',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // İstatistikler
                  _buildStatsCard(),
                  const SizedBox(height: 16),

                  // Butonlar
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _addTestData,
                          icon: const Icon(Icons.add),
                          label: const Text('Test Verisi Ekle'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _clearDatabase,
                          icon: const Icon(Icons.delete),
                          label: const Text('Temizle'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Yakınlar
                  _buildSectionTitle('Yakınlar (${_contacts.length})'),
                  _buildDataList(_contacts, ['name', 'phone', 'created_at']),

                  const SizedBox(height: 16),

                  // Güvendeyim Kayıtları
                  _buildSectionTitle('Güvendeyim Kayıtları (${_safeStatus.length})'),
                  _buildDataList(_safeStatus, ['message', 'timestamp']),

                  const SizedBox(height: 16),

                  // Depremler
                  _buildSectionTitle('Deprem Kayıtları (${_earthquakes.length})'),
                  _buildDataList(_earthquakes, ['title', 'magnitude', 'date_time']),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage, color: Colors.purple.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Veritabanı İstatistikleri',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildStatRow('Yakınlar', _stats['contacts'] ?? 0, Icons.people),
            _buildStatRow('Güvendeyim Kayıtları', _stats['safe_status'] ?? 0, Icons.check_circle),
            _buildStatRow('Deprem Kayıtları', _stats['earthquakes'] ?? 0, Icons.public),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _buildDataList(List<Map<String, dynamic>> data, List<String> keys) {
    if (data.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Veri yok',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      );
    }

    return Column(
      children: data.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: keys.map((key) {
                final value = item[key];
                if (value == null) return const SizedBox.shrink();
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '$key:',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          value.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
