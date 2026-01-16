// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/contacts_service.dart';

/// Güvendeyim ve Acil Durum ekranı - Mesaj gösterme ve SMS hazırlama
class SafeModeScreen extends StatefulWidget {
  final String message;
  final DateTime timestamp;
  final bool isEmergency; // Acil durum modu mu?

  const SafeModeScreen({
    super.key,
    required this.message,
    required this.timestamp,
    this.isEmergency = false, // Varsayılan: normal güvendeyim modu
  });

  @override
  State<SafeModeScreen> createState() => _SafeModeScreenState();
}

class _SafeModeScreenState extends State<SafeModeScreen> {
  final ContactsService _contactsService = ContactsService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> _contacts = [];
  bool _isLoading = true;
  bool _isSirenPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadContacts();
    
    // Eğer acil durum modundaysa alarm çal
    if (widget.isEmergency) {
      _playEmergencyAlarm();
    }
  }
  
  /// Acil durum alarm sesi (titreşim ile)
  void _playEmergencyAlarm() {
    // İlk titreşim
    HapticFeedback.heavyImpact();
    
    // 3 kez tekrarla
    Future.delayed(const Duration(milliseconds: 300), () {
      HapticFeedback.heavyImpact();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      HapticFeedback.heavyImpact();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      HapticFeedback.heavyImpact();
    });
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
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Yüksek sesli siren çal/durdur
  Future<void> _playSiren() async {
    setState(() {
      _isSirenPlaying = !_isSirenPlaying;
    });

    if (_isSirenPlaying) {
      try {
        // Ses dosyasını çalmayı dene
        try {
          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
          await _audioPlayer.setVolume(1.0);
          await _audioPlayer.play(AssetSource('sounds/siren.mp3'));
          
          // Siren aktif mesajı (ses ile)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🚨 SİREN ÇALIYOR - Yüksek ses ve titreşim aktif!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        } catch (audioError) {
          // Ses dosyası yoksa sadece titreşim
          debugPrint('⚠️ Ses dosyası bulunamadı, sadece titreşim: $audioError');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🚨 SİREN ÇALIYOR - Titreşim aktif (Ses dosyası eklenmemiş)'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
        }
        
        // Sürekli titreşim döngüsü başlat (ses varsa da yoksa da)
        _startSirenVibration();
        
      } catch (e) {
        debugPrint('❌ Siren hatası: $e');
        setState(() {
          _isSirenPlaying = false;
        });
      }
    } else {
      // Sesi durdur
      await _audioPlayer.stop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⏸️ Siren durduruldu'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  /// Siren titreşimi (sürekli döngü)
  void _startSirenVibration() {
    if (_isSirenPlaying) {
      // Hızlı titreşim - siren etkisi
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(milliseconds: 200), () {
        if (_isSirenPlaying) {
          HapticFeedback.heavyImpact();
          Future.delayed(const Duration(milliseconds: 200), () {
            if (_isSirenPlaying) {
              _startSirenVibration(); // Tekrar başlat
            }
          });
        }
      });
    }
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
              backgroundColor: Colors.green,
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

  @override
  Widget build(BuildContext context) {
    // Renk ve başlık acil durum moduna göre değişir
    final titleColor = widget.isEmergency ? Colors.red.shade700 : Colors.green;
    final titleText = widget.isEmergency ? '🆘 ACİL DURUM' : 'Güvendeyim';
    final iconData = widget.isEmergency ? Icons.warning_amber_rounded : Icons.check_circle;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          titleText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: titleColor,
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
                  // İkon (Acil duruma göre değişir)
                  Icon(
                    iconData,
                    size: 100,
                    color: titleColor,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    widget.isEmergency ? 'Acil Durum Mesajı Oluşturuldu' : 'Güvendeyim Mesajı Oluşturuldu',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                      border: Border.all(color: Colors.green.shade200, width: 2),
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
                            Icon(Icons.message, color: Colors.green.shade700),
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
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  
                  // SİREN butonu (Sadece acil durum modunda)
                  if (widget.isEmergency) ...[
                    const SizedBox(height: 20),
                    
                    ElevatedButton.icon(
                      onPressed: _playSiren,
                      icon: Icon(_isSirenPlaying ? Icons.volume_off : Icons.campaign),
                      label: Text(
                        _isSirenPlaying ? 'SİRENİ DURDUR' : '🚨 YÜKSEK SESLİ SİREN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSirenPlaying ? Colors.orange.shade700 : Colors.red.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Siren bilgisi
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
                              'Enkaz altında veya tehlikedeyseniz, siren ile dikkat çekin!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 30),
                  
                  // Yakınlar bilgisi
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Yakınlarım (${_contacts.length})',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
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
                                      color: Colors.blue.shade700,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      contact,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue.shade900,
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
                                color: Colors.blue.shade700,
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
                      'YAKINLARA GÖNDER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green.shade800),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'SMS uygulamanız mesajla birlikte açılacak. Sadece gönder butonuna basın!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade900,
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
