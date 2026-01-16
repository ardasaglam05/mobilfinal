// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// İlk Yardım Rehberi - Offline çalışır
class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          '🏥 İlk Yardım Rehberi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bilgi notu
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'İnternet olmadan çalışır. Acil durumlarda hızlıca başvurun!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // İlk yardım kategorileri
          _buildFirstAidCard(
            context,
            icon: Icons.bloodtype,
            title: 'Kanamayı Durdurma',
            color: Colors.red,
            steps: [
              '1. Yaralıyı sakin tutun ve güvenli bir yere alın',
              '2. Temiz bir bez veya gazlı bezle kanayan bölgeye baskı uygulayın',
              '3. Baskıyı 10-15 dakika kesintisiz sürdürün',
              '4. Yaralı bölgeyi kalp seviyesinden yukarı kaldırın',
              '5. Kanama durmuyorsa 112 acil servisi arayın',
              '⚠️ DİKKAT: Yara içindeki cisimleri çıkarmayın!',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.medical_services,
            title: 'Turnike Kullanımı',
            color: Colors.orange,
            steps: [
              '1. Sadece çok şiddetli kanamada kullanın',
              '2. Yaranın kalbe yakın kısmına uygulayın (kol veya bacağın üst kısmı)',
              '3. Geniş bir bez veya kumaş kullanın (en az 5 cm genişlik)',
              '4. Sıkıca bağlayın ve kanama durana kadar sıkıştırın',
              '5. Turnikenin saatini not alın',
              '6. HEMEN 112 arayın - Turnike acil müdahale gerektirir!',
              '⚠️ DİKKAT: 2 saatten fazla bağlı bırakmayın!',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.favorite,
            title: 'Kalp Masajı (CPR)',
            color: Colors.pink,
            steps: [
              '1. Kişinin bilinci ve nefesi yoksa 112 arayın',
              '2. Kişiyi sırt üstü yatırın, sert zemin gerekir',
              '3. Göğsün ortasına iki elinizi üst üste koyun',
              '4. Kollarınızı düz tutarak göğsü 5-6 cm bastırın',
              '5. Dakikada 100-120 bası yapın (2 basış/saniye)',
              '6. Her 30 basıda 2 nefes verin (eğer biliyorsanız)',
              '7. Ambulans gelene kadar devam edin',
              '🎵 İpucu: "Stayin\' Alive" şarkısının ritmi idealdir',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.local_fire_department,
            title: 'Yanık Tedavisi',
            color: Colors.deepOrange,
            steps: [
              '1. Yanık bölgeyi hemen soğuk suyla yıkayın (10-20 dakika)',
              '2. Takıları ve sıkı giysileri çıkarın',
              '3. Temiz bir bezle örtün',
              '4. Buz veya diş macunu KULLANMAYIN!',
              '5. Kabarcıkları patlatmayın',
              '6. Ciddi yanıklarda 112 arayın',
              '⚠️ Elektrik yanıklarında önce gücü kesin!',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.psychology,
            title: 'Bayılma',
            color: Colors.purple,
            steps: [
              '1. Kişiyi sırt üstü yatırın',
              '2. Bacaklarını kalbe göre yukarı kaldırın (30 cm)',
              '3. Dar giysileri gevşetin',
              '4. Başını yana çevirin (kusma olursa)',
              '5. 1-2 dakikada kendine gelmezse 112 arayın',
              '6. Ayıldıktan sonra hemen kaldırmayın, 10 dk bekletin',
              '⚠️ Yüzüne su dökmeyin veya tokat atmayın!',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.air,
            title: 'Boğulma',
            color: Colors.blue,
            steps: [
              '1. Kişiye "Boğuluyor musunuz?" diye sorun',
              '2. Sırtına 5 kez sert vurun (kürek kemiği arası)',
              '3. Arkadan sarın ve göbeğin üstüne yumruk koyun',
              '4. İçeri-yukarı doğru 5 kez bastırın (Heimlich manevrası)',
              '5. Cisim çıkana kadar tekrarlayın',
              '6. Bilincini kaybederse CPR başlatın',
              '⚠️ Bebeklerde farklı teknik gerekir - 112 arayın!',
            ],
          ),
          
          _buildFirstAidCard(
            context,
            icon: Icons.pets,
            title: 'Hayvan Isırığı',
            color: Colors.brown,
            steps: [
              '1. Yarayı bol sabunlu suyla yıkayın (15 dakika)',
              '2. Temiz bezle örtün',
              '3. Hayvanın kuduz aşısı olup olmadığını öğrenin',
              '4. En yakın sağlık kuruluşuna başvurun',
              '5. Yılana ısırıkta: Hareketsiz kalın, zehir yayılmasın',
              '⚠️ DİKKAT: Yılan ısırıklarında turnike YAPMAYIN!',
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Uyarı
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200, width: 2),
            ),
            child: Column(
              children: [
                Icon(Icons.warning_amber, color: Colors.red.shade700, size: 32),
                const SizedBox(height: 8),
                Text(
                  'ÖNEMLİ UYARI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bu bilgiler genel ilk yardım bilgileridir. Ciddi durumlarda mutlaka 112 acil servisi arayın. Profesyonel tıbbi yardım almanın yerini tutmaz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstAidCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required List<String> steps,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: steps.map((step) {
                final isWarning = step.startsWith('⚠️') || step.startsWith('🎵');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isWarning)
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: color,
                        ),
                      if (!isWarning) const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          step,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: isWarning ? FontWeight.bold : FontWeight.normal,
                            color: isWarning ? color : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
