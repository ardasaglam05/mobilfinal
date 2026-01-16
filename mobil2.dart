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
   - 🗺️ Güvenli Toplanma Alanları

4. **🔵 Yakınlar Yönetimi**
   - Acil durum kişileri ekleme/silme
   - Telefon numarası yönetimi
   - SQLite veritabanı ile kalıcı saklama

### 🆕 Yeni Eklenen Özellikler

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

#### 🗺️ Güvenli Toplanma Alanları
- Örnek toplanma alanları (İstanbul)
- Kapasite ve mesafe bilgisi
- Olanaklar listesi (Su, WC, vb.)
- **Google Maps entegrasyonu**
- "HARITADA GÖSTER VE ROTA ÇİZ" butonu

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
│   ├── safe_zones_screen.dart        # 🆕 Toplanma alanları
│   └── database_debug_screen.dart    # Veritabanı debug
├── services/
│   ├── message_service.dart          # Mesaj oluşturma
│   ├── safe_status_service.dart      # Güvendeyim kaydı
│   ├── contacts_service.dart         # Yakınlar servisi
│   └── earthquake_service.dart       # Deprem API
└── database/
    └── database_helper.dart          # SQLite yönetimi
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
- Fiziksel cihaz bağlayın

### 4️⃣ Çalıştırma
**Yöntem 1:** `F5` tuşuna basın

**Yöntem 2:** Terminal'de
```bash
flutter run
```

**Yöntem 3:** VS Code'da
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
- [x] Toplanma alanları + Google Maps
- [x] Acil durum siren

### 🎨 Kullanıcı Arayüzü
- Modern ve kullanıcı dostu tasarım
- Renk kodlu butonlar (Yeşil, Kırmızı, Mavi)
- Card tabanlı liste görünümleri
- Genişletilebilir kategoriler
- Responsive layout

## 📝 Notlar

### Offline Çalışma
- İlk yardım rehberi tamamen offline
- Toplanma alanları örnek verilerle offline
- Deprem verileri internet gerektirir
- SMS göndermek için SIM kart gerekir

### İzinler (AndroidManifest.xml)
- `INTERNET` - Deprem API için
- `ACCESS_FINE_LOCATION` - GPS konum için
- `ACCESS_COARSE_LOCATION` - Yaklaşık konum için

### Önemli
- İlk çalıştırmada konum izni isteyecektir
- SMS gönderme telefon SIM kartı gerektirir
- Google Maps açmak için internet gerekir

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

## 📄 Lisans

Eğitim amaçlı geliştirilmiştir.

---

**Geliştirme Tarihi:** Ocak 2026  
**Flutter Versiyon:** 3.9.2+  
**Platform:** Android, iOS, Web, Windows, macOS (desteklenir)
