YOUTUBE VİDEO LİNKİ : https://youtu.be/t3U95yGzc5U



[README.md](https://github.com/user-attachments/files/24675954/README.md)
 Acil Durum Asistanı 

Flutter ile geliştirilmiş, acil durum yönetim uygulaması.

  Özellikler

 Ana Özellikler
1.**🟢 Güvendeyim Butonu**
   - Otomatik GPS konum paylaşımı (Google Maps linki)
   - Batarya durumu paylaşımı
   - SMS ile yakınlara otomatik bildirim

2. **🔴 Güvende Değilim (Acil Durum)**
   - Acil durum mesajı (konum + batarya)
   - 🚨 Yüksek sesli siren özelliği
   - Otomatik alarm sesi (4x titreşim)
   - SMS ile acil yardım talebi

3. **🟠 Deprem Bilgileri**
   - Canlı deprem verileri (Kandilli)
   - Deprem anında yapılacaklar listesi
   -  İlk Yardım Rehberi (offline)
   - Güvenli Toplanma Alanları (27+ İstanbul geneli)

4. **🔵 Yakınlar Yönetimi**
   - Acil durum kişileri ekleme/silme
   - Telefon numarası yönetimi
   - SQLite veritabanı ile kalıcı saklama

🆕 Yeni Eklenen Özellikler

 🇹🇷 Türk Kullanıcılara Özel Uygulama İkonu
- Türk bayrağı renkleri (kırmızı arka plan)
- Ay-yıldız sembolü ile kültürel uyum
- Acil durum haçı ile işlevsellik
- Koruyucu kalkan tasarımı
- Tüm platformlarda (Android, iOS, Web, Windows, macOS) desteklenir

🏥 İlk Yardım Rehberi (Offline)
- *7 Kategori** ile kapsamlı rehber:
  - 🩸 Kanamayı Durdurma
  - 🔴 Turnike Kullanımı
  - ❤️ Kalp Masajı (CPR)
  - 🔥 Yanık Tedavisi
  - 😵 Bayılma
  - 🫁 Boğulma (Heimlich)
  - 🐕 Hayvan Isırığı
- İnternet gerektirmez
- Adım adım talimatlar
- Önemli uyarılar vurgulanmış

Güvenli Toplanma Alanları (27+ Alan - İstanbul)
- **Avrupa Yakası - Merkezi:**
  - Taksim Gezi Parkı, Maçka Demokrasi Parkı, Yıldız Parkı
  - Abbasağa Parkı, Emirgan Korusu, Bebek Parkı
  - Gülhane Parkı, AOÇ İstanbul, Belgrad Ormanı

- **Avrupa Yakası - Batı:**
  - Atatürk Havalimanı Açık Alanı, Küçükçekmece Gölü Parkı
  - Florya Atatürk Ormanı, Yeşilköy Sahili, Bahçeşehir Gölet Parkı

- **Anadolu Yakası - Merkezi:**
  - Fenerbahçe Parkı, Göztepe 60. Yıl Parkı, Validebağ Korusu
  - Fethi Paşa Korusu, Çamlıca Tepesi Parkı, Polonezköy Tabiat Parkı

- **Anadolu Yakası - Doğu:**
  - Aydos Ormanı, Maltepe Sahil Parkı, Kartal Sahil Parkı
  - Sancaktepe Millet Bahçesi, Dragos Sahili, Çekmeköy Millet Bahçesi

- **Özellikler:**
  - Kapasite ve mesafe bilgisi
  - Olanaklar listesi (Su, WC, Otopark vb.)
  - **Google Maps entegrasyonu**
  - "HARITADA GÖSTER VE ROTA ÇİZ" butonu
  - İnternet olmadan görüntülenebilir

 🚨 Acil Durum Siren
- Sadece acil durum modunda aktif
- Sürekli titreşim döngüsü
- Enkaz altında dikkat çekmek için


 Proje Yapısı

```
lib/
├── main.dart                          # Ana giriş
├── screens/
│   ├── home_screen.dart              # Ana ekran (4 buton)
│   ├── safe_mode_screen.dart         # Güvendeyim/Acil Durum ekranı
│   ├── emergency_mode_screen.dart    # Eski acil durum ekranı
│   ├── contacts_screen.dart          # Yakınlar yönetimi
│   ├── earthquake_screen.dart        # Deprem bilgileri
│   ├── first_aid_screen.dart         #  İlk yardım rehberi
│   ├── safe_zones_screen.dart        #  Toplanma alanları (27+)
│   └── database_debug_screen.dart    # Veritabanı debug
├── services/
│   ├── message_service.dart          # Mesaj oluşturma
│   ├── safe_status_service.dart      # Güvendeyim kaydı
│   ├── contacts_service.dart         # Yakınlar servisi
│   └── earthquake_service.dart       # Deprem API
└── database/
    └── database_helper.dart          # SQLite yönetimi

assets/
├── icons/
│   └── app_icon.png                  #  Türk temalı uygulama ikonu
└── sounds/
    └── emergency_whistle.mp3         # Acil durum düdüğü
```





 
```

## 🎯 Özellik Listesi

Tamamlanan Özellikler
Güvendeyim butonu + GPS konum
 Güvende Değilim butonu + acil durum
 Batarya durumu paylaşımı
 SMS otomatik hazırlama
 Yakınlar yönetimi
 SQLite veritabanı
 Deprem bilgileri (API)
 İlk yardım rehberi (offline)
 Toplanma alanları + Google Maps (27+ alan)
 Acil durum siren
 Türk kullanıcılara özel uygulama ikonu


## 📝 Notlar

### Offline Çalışma
- İlk yardım rehberi tamamen offline
- Toplanma alanları (27+ alan) offline görüntülenebilir
- Deprem verileri internet gerektirir
- SMS göndermek için SIM kart gerekir
- Google Maps rotası için internet gerekir

### İzinler (AndroidManifest.xml)
- `INTERNET` - Deprem API için
- `ACCESS_FINE_LOCATION` - GPS konum için
- `ACCESS_COARSE_LOCATION` - Yaklaşık konum için

### Önemli
- İlk çalıştırmada konum izni isteyecektir
- SMS gönderme telefon SIM kartı gerektirir
- Google Maps açmak için internet gerekir
- Uygulama ikonu otomatik tüm platformlara uygulanır


```

```

- Her iki mesaj da konum ve batarya destekli

Safe Zones Screen
- 27+ İstanbul toplanma alanı
- Avrupa ve Anadolu yakası bölgeleri
- GPS koordinatları ile Google Maps entegrasyonu
- Kapasite ve olanaklar bilgisi



 Uygulama İkonu
Renk Paleti:** Türk bayrağı kırmızısı (#E30A17)
Semboller:** Ay-yıldız (Türk kültürü) + Acil durum haçı






---


