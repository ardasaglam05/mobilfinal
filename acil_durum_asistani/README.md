# Acil Durum Asistanı 🚨

Flutter ile geliştirilmiş, **offline çalışabilen** acil durum yönetim uygulaması.

## ✨ Özellikler

### 🏠 Ana Özellikler
1. **🟢 Güvendeyim Butonu**
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
   - 🏥 İlk Yardım Rehberi (offline)
   - 🗺️ Güvenli Toplanma Alanları (27+ İstanbul geneli)

4. **🔵 Yakınlar Yönetimi**
   - Acil durum kişileri ekleme/silme
   - Telefon numarası yönetimi
   - SQLite veritabanı ile kalıcı saklama

### 🆕 Yeni Eklenen Özellikler

#### 🇹🇷 Türk Kullanıcılara Özel Uygulama İkonu
- Türk bayrağı renkleri (kırmızı arka plan)
- Ay-yıldız sembolü ile kültürel uyum
- Acil durum haçı ile işlevsellik
- Koruyucu kalkan tasarımı
- Tüm platformlarda (Android, iOS, Web, Windows, macOS) desteklenir

#### 🏥 İlk Yardım Rehberi (Offline)
- **7 Kategori** ile kapsamlı rehber:
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

#### 🗺️ Güvenli Toplanma Alanları (27+ Alan - İstanbul)
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

#### 🚨 Acil Durum Siren
- Sadece acil durum modunda aktif
- Sürekli titreşim döngüsü
- Enkaz altında dikkat çekmek için

## 📱 Kullanılan Teknolojiler

- **Flutter** 3.9.2+
- **Dart** SDK
- **SQLite** - Offline veri saklama
- **Geolocator** - GPS konum
- **Battery Plus** - Batarya durumu
- **Audioplayers** - Ses/siren
- **URL Launcher** - SMS ve Google Maps
- **HTTP** - Deprem API
- **Shared Preferences** - Basit veri saklama
- **Flutter Launcher Icons** - Çoklu platform ikon oluşturma

## 🗂️ Proje Yapısı

```
lib/
├── main.dart                          # Ana giriş
├── screens/
│   ├── home_screen.dart              # Ana ekran (4 buton)
│   ├── safe_mode_screen.dart         # Güvendeyim/Acil Durum ekranı
│   ├── emergency_mode_screen.dart    # Eski acil durum ekranı
│   ├── contacts_screen.dart          # Yakınlar yönetimi
│   ├── earthquake_screen.dart        # Deprem bilgileri
│   ├── first_aid_screen.dart         # 🆕 İlk yardım rehberi
│   ├── safe_zones_screen.dart        # 🆕 Toplanma alanları (27+)
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
│   └── app_icon.png                  # 🆕 Türk temalı uygulama ikonu
└── sounds/
    └── emergency_whistle.mp3         # Acil durum düdüğü
```

## 🚀 Visual Studio Code'da Çalıştırma

### 1️⃣ Proje Açma
```bash
# VS Code'u aç
code .
# VEYA
# File > Open Folder > acil_durum_asistani
```

### 2️⃣ Bağımlılıkları Yükleme
VS Code terminal'de:
```bash
flutter pub get
```

### 3️⃣ Cihaz/Emülatör Seçme
- VS Code alt barında cihaz seçici var
- Android emülatör başlatın VEYA
- Fiziksel cihaz bağlayın VEYA
- Chrome (Web) seçin

### 4️⃣ Çalıştırma
**Yöntem 1:** `F5` tuşuna basın

**Yöntem 2:** Terminal'de
```bash
flutter run
```

**Yöntem 3:** Web için
```bash
flutter run -d chrome
```

**Yöntem 4:** VS Code'da
- `Run > Start Debugging` (F5)
- `Run > Run Without Debugging` (Ctrl+F5)

## 🔧 Gereksinimler

### Minimum Gereksinimler
- Flutter SDK: 3.9.2+
- Dart SDK: 3.0+
- Android Studio (Android geliştirme için)
- Android SDK minimum: API 21 (Android 5.0)

### VS Code Eklentileri
1. **Flutter** (Dart-Code.flutter)
2. **Dart** (Dart-Code.dart-code)

### Platform Gereksinimleri
- **Android:** Android Studio + Android SDK
- **iOS:** Xcode (sadece macOS'ta)
- **Web:** Chrome tarayıcı
- **Windows Desktop:** Visual Studio 2022 + C++ Desktop Development
- **macOS Desktop:** Xcode
- **Linux Desktop:** Clang, CMake, Ninja

## 📦 Kurulum

1. **Flutter SDK Kurulumu**
   - https://flutter.dev/docs/get-started/install

2. **VS Code Eklentileri**
   - Flutter eklentisini yükleyin
   - Dart eklentisi otomatik gelecektir

3. **Android Studio** (Android için)
   - Android SDK
   - Android Emulator

4. **Proje Kurulumu**
```bash
cd acil_durum_asistani
flutter pub get
flutter pub run flutter_launcher_icons  # İkonları oluştur
flutter run
```

## 🎯 Özellik Listesi

### ✅ Tamamlanan Özellikler
- [x] Güvendeyim butonu + GPS konum
- [x] Güvende Değilim butonu + acil durum
- [x] Batarya durumu paylaşımı
- [x] SMS otomatik hazırlama
- [x] Yakınlar yönetimi
- [x] SQLite veritabanı
- [x] Deprem bilgileri (API)
- [x] İlk yardım rehberi (offline)
- [x] Toplanma alanları + Google Maps (27+ alan)
- [x] Acil durum siren
- [x] Türk kullanıcılara özel uygulama ikonu

### 🎨 Kullanıcı Arayüzü
- Modern ve kullanıcı dostu tasarım
- Türk kültürüne uygun ikonografi (🇹🇷 ay-yıldız)
- Renk kodlu butonlar (Yeşil, Kırmızı, Mavi)
- Card tabanlı liste görünümleri
- Genişletilebilir kategoriler
- Responsive layout

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

## 🐛 Hata Ayıklama

### Konum Çalışmıyor
```bash
# Android ayarlarında konum izinlerini kontrol edin
# Emülatörde GPS'i etkinleştirin
```

### Build Hatası
```bash
flutter clean
flutter pub get
flutter run
```

### İkon Güncelleme
```bash
flutter pub run flutter_launcher_icons
```

### Hot Reload Çalışmıyor
```bash
# Terminal'de 'r' tuşuna basın (hot reload)
# VEYA 'R' tuşuna basın (hot restart - yeni dosyalar için)
```

## 📞 Acil Numaralar

- 112 - Acil Sağlık
- 155 - Polis
- 110 - İtfaiye
- 156 - Jandarma

## 👨‍💻 Geliştirici Notları

### Database Debug Ekranı
- Ana ekranda sağ üstte veritabanı ikonu
- Tüm kayıtları görüntüleme
- Test verisi ekleme
- Veritabanını temizleme

### Message Service
- `createSafeMessage()` - Güvendeyim mesajı
- `createEmergencyMessage()` - Acil durum mesajı
- Her iki mesaj da konum ve batarya destekli

### Safe Zones Screen
- 27+ İstanbul toplanma alanı
- Avrupa ve Anadolu yakası bölgeleri
- GPS koordinatları ile Google Maps entegrasyonu
- Kapasite ve olanaklar bilgisi

## 🎨 Tasarım Kararları

### Uygulama İkonu
- **Renk Paleti:** Türk bayrağı kırmızısı (#E30A17)
- **Semboller:** Ay-yıldız (Türk kültürü) + Acil durum haçı
- **Form:** Koruyucu kalkan tasarımı
- **Platform Desteği:** Android, iOS, Web, Windows, macOS

## 📄 Lisans

Eğitim amaçlı geliştirilmiştir.

---

**Geliştirme Tarihi:** Ocak 2026  
**Flutter Versiyon:** 3.9.2+  
**Platform:** Android, iOS, Web, Windows, macOS (desteklenir)  
**Son Güncelleme:** 16 Ocak 2026 - Türk temalı ikon ve 27 toplanma alanı eklendi
