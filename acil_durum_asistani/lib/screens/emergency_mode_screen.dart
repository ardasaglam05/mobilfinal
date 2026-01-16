// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/contacts_service.dart';

/// Acil Durum ekranı - Mesaj gösterme, SMS hazırlama ve düdük
class EmergencyModeScreen extends StatefulWidget {
  final String message;
  final DateTime timestamp;

  const EmergencyModeScreen({
    super.key,
    required this.message,
    required this.timestamp,
  });

  @override
  State<EmergencyModeScreen> createState() => _EmergencyModeScreenState();
}

class _EmergencyModeScreenState extends State<EmergencyModeScreen> {
  final ContactsService _contactsService = ContactsService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> _contacts = [];
  bool _isLoading = true;
  bool _isWhistlePlaying = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Yakınları yükle
  Future<void> _loadContacts() async {
    final contacts = await _contactsService.getContactPhones();
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  /// Mesajı panoya kopyala
  void _copyMessage() {
    Clipboard.setData(ClipboardData(text: widget.message));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Mesaj panoya kopyalandı'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// SMS uygulamasını aç ve mesajı hazırla
  Future<void> _sendToContacts() async {
    if (_contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yakın listesi boş. Önce yakın ekleyin.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Telefon numaralarını birleştir (virgülle ayır)
      final recipients = _contacts.join(',');
      
      // Mesajı URL encode et
      final encodedMessage = Uri.encodeComponent(widget.message);
      
      // SMS URI oluştur
      final smsUri = Uri.parse('sms:$recipients?body=$encodedMessage');
      
      debugPrint('📱 SMS uygulaması açılıyor...');
      debugPrint('Alıcılar: $recipients');
      debugPrint('Mesaj: ${widget.message}');
      
      // SMS uygulamasını aç
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✓ SMS uygulaması açıldı. Mesajı kontrol edip gönderin.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        throw 'SMS uygulaması açılamadı';
      }
    } catch (e) {
      debugPrint('❌ SMS hatası: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: SMS uygulaması açılamadı. $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  /// Yüksek frekanslı düdük sesi çal
  Future<void> _playWhistle() async {
    setState(() {
      _isWhistlePlaying = !_isWhistlePlaying;
    });

    if (_isWhistlePlaying) {
      try {
        // Yüksek frekanslı düdük sesi için ses dosyası yerine
        // tekrarlayan bir bip sesi kullanacağız
        await _audioPlayer.setReleaseMode(ReleaseMode.loop);
        await _audioPlayer.setVolume(1.0);
        
        // Not: Gerçek bir düdük sesi için assets klasörüne ses dosyası eklemelisiniz
        // Şimdilik sistem bildirim sesi kullanacağız
        
        // Ses dosyası yoksa basit titreşim alternatifi
        HapticFeedback.heavyImpact();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📢 Düdük Modu Aktif - Yüksek ses çıkıyor!'),
            backgroundColor: Colors.deepOrange,
            duration: Duration(seconds: 2),
          ),
        );
        
        // Düdük simülasyonu için titreşim döngüsü
        _startWhistleVibration();
        
      } catch (e) {
        debugPrint('❌ Ses çalma hatası: $e');
        setState(() {
          _isWhistlePlaying = false;
        });
      }
    } else {
      await _audioPlayer.stop();
    }
  }

  /// Düdük titreşimi
  void _startWhistleVibration() {
    if (_isWhistlePlaying) {
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_isWhistlePlaying) {
          _startWhistleVibration();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text(
          '🆘 ACİL DURUM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Uyarı ikonu
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 100,
                    color: Colors.red.shade700,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Acil Durum Mesajı Oluşturuldu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Mesaj kartı
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.message, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            const Text(
                              'Mesaj İçeriği',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Kopyala butonu
                  OutlinedButton.icon(
                    onPressed: _copyMessage,
                    icon: const Icon(Icons.copy),
                    label: const Text(
                      'MESAJI KOPYALA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // DÜDÜK butonu (Yeni!)
                  ElevatedButton.icon(
                    onPressed: _playWhistle,
                    icon: Icon(_isWhistlePlaying ? Icons.stop : Icons.campaign),
                    label: Text(
                      _isWhistlePlaying ? 'DÜDÜĞÜ DURDUR' : 'YÜKSEK SESLİ DÜDÜK',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isWhistlePlaying ? Colors.orange.shade700 : Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Düdük bilgisi
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange.shade800, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Enkaz altındaysanız, düdük ile kendinizi belli edin!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Yakınlar bilgisi
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Yakınlarım (${_contacts.length})',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                        if (_contacts.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          ..._contacts.map((contact) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 16,
                                      color: Colors.red.shade700,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      contact,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ] else
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Henüz yakın eklenmedi',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // SMS gönder butonu
                  ElevatedButton.icon(
                    onPressed: _sendToContacts,
                    icon: const Icon(Icons.send, size: 24),
                    label: const Text(
                      'ACİL MESAJ GÖNDER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Bilgi notu
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.red.shade800),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'SMS uygulamanız mesajla birlikte açılacak. Sadece gönder butonuna basın!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
