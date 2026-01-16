# 📊 ACİL DURUM ASİSTANI - PROJE RAPORU

**Proje Adı:** Acil Durum Asistanı  
**Geliştirme Platformu:** Flutter  
**Hedef Platform:** Android (iOS uyumlu)  
**Tarih:** 07.01.2026

---

## 📋 İÇİNDEKİLER

1. [Proje Özeti](#proje-özeti)
2. [Teknik Mimari](#teknik-mimari)
3. [Özellikler](#özellikler)
4. [Dosya Yapısı](#dosya-yapısı)
5. [Kullanılan Teknolojiler](#kullanılan-teknolojiler)
6. [Kurulum ve Çalıştırma](#kurulum-ve-çalıştırma)
7. [Ekran Görüntüleri ve Açıklamalar](#ekran-görüntüleri-ve-açıklamalar)
8. [Test Senaryoları](#test-senaryoları)
9. [Gelecek Geliştirmeler](#gelecek-geliştirmeler)
10. [Sonuç](#sonuç)

---

## 🎯 PROJE ÖZETİ

### Amaç
Deprem ve acil durumlarda **internet bağlantısı olmasa bile** kullanılabilecek, kullanıcının güvende olduğunu yakınlarına bildirebileceği bir mobil uygulama geliştirmek.

### Problem
- Deprem anında internet altyapısı çökebilir
- Yakınlarla iletişim kurmak zorlaşır
- Acil durum bilgileri kaybolabilir

### Çözüm
- **Offline-first** mimari ile internet gerektirmeyen uygulama
- Yerel veri saklama ile bilgi kaybı önleme
- Basit ve hızlı kullanıcı arayüzü

---

## 🏗️ TEKNİK MİMARİ

### Mimari Yaklaşım: Offline-First

```
┌─────────────────────────────────────┐
│         Kullanıcı Arayüzü           │
│    (Flutter Material Design 3)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│          Screens (Ekranlar)         │
│  • HomeScreen                       │
│  • ContactsScreen                   │
│  • SafeModeScreen                   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        Services (Servisler)         │
│  • SafeStatusService                │
│  • MessageService                   │
│  • ContactsService                  │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Veri Katmanı (Offline)         │
│    shared_preferences (Key-Value)   │
└─────────────────────────────────────┘
```

### Veri Akışı

1. **Kullanıcı Aksiyonu** → Butona basma
2. **Screen** → Servisi çağırma
3. **Service** → Veriyi işleme
4. **shared_preferences** → Veriyi cihazda saklama
5. **UI Güncelleme** → Kullanıcıya geri bildirim

---

## ✨ ÖZELLİKLER

### 1. Ana Ekran (HomeScreen)

**Fonksiyonlar:**
- 🟠 **DEPREM** butonu - Test amaçlı (ileride AFAD entegrasyonu)
- 🟢 **GÜVENDEYİM** butonu - Güvendeyim mesajı oluşturma
- 👨‍👩‍👧‍👦 **YAKINLAR** butonu - Yakınları yönetme
- Son güvendeyim zamanını gösterme

**Teknik Detaylar:**
- StatefulWidget kullanımı
- Lifecycle yönetimi (initState)
- Navigation (MaterialPageRoute)
- SnackBar ile kullanıcı geri bildirimi

### 2. Yakınlar Ekranı (ContactsScreen)

**Fonksiyonlar:**
- Telefon numarası ekleme
- Eklenen numaraları listeleme
- Numara silme (onay dialogu ile)
- Boş durum (empty state) gösterimi

**Teknik Detaylar:**
- TextEditingController ile input yönetimi
- ListView.builder ile dinamik liste
- Dialog kullanımı
- Validasyon (telefon numarası kontrolü)

### 3. Güvendeyim Ekranı (SafeModeScreen)

**Fonksiyonlar:**
- Otomatik mesaj oluşturma
- Mesajı panoya kopyalama
- Yakınlar listesini gösterme
- SMS gönderme simülasyonu (test modu)

**Teknik Detaylar:**
- Clipboard API kullanımı
- Parametre geçişi (message, timestamp)
- Conditional rendering
- SingleChildScrollView ile scroll desteği

---

## 📁 DOSYA YAPISI

```
acil_durum_asistani/
│
├── lib/
│   ├── main.dart                      # Uygulama giriş noktası
│   │
│   ├── screens/                       # UI Ekranları
│   │   ├── home_screen.dart          # Ana ekran (3 buton)
│   │   ├── contacts_screen.dart      # Yakınlar yönetimi
│   │   └── safe_mode_screen.dart     # Güvendeyim mesaj ekranı
│   │
│   └── services/                      # İş mantığı servisleri
│       ├── safe_status_service.dart  # Güvendeyim durumu
│       ├── message_service.dart      # Mesaj oluşturma
│       └── contacts_service.dart     # Yakınlar veri yönetimi
│
├── test/
│   └── widget_test.dart              # Widget testleri
│
├── pubspec.yaml                       # Bağımlılıklar
└── README.md                          # Proje dokümantasyonu
```

**Toplam Kod Satırı:** ~800 satır  
**Dosya Sayısı:** 7 Dart dosyası  
**Servis Sayısı:** 3 servis  
**Ekran Sayısı:** 3 ekran

---

## 🔧 KULLANILAN TEKNOLOJİLER

### Framework & Dil
- **Flutter 3.35.5** - Cross-platform UI framework
- **Dart 3.9.2** - Programlama dili

### Paketler (Dependencies)

#### 1. shared_preferences (^2.2.2)
**Amaç:** Offline veri saklama  
**Kullanım Alanları:**
- Yakınların telefon numaralarını saklama
- Son güvendeyim zamanını saklama
- Key-value storage

**Örnek Kod:**
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('safe_time', time.toIso8601String());
```

#### 2. intl (^0.19.0)
**Amaç:** Tarih/saat formatı  
**Kullanım Alanları:**
- Türkçe tarih formatı (dd.MM.yyyy)
- Saat formatı (HH:mm)

**Örnek Kod:**
```dart
final dateFormat = DateFormat('dd.MM.yyyy');
final date = dateFormat.format(DateTime.now());
```

### UI/UX
- **Material Design 3** - Modern UI tasarımı
- **Custom Color Scheme** - Acil durum teması (kırmızı)
- **Responsive Layout** - Farklı ekran boyutları

---

## 🚀 KURULUM VE ÇALIŞTIRMA

### Gereksinimler
- Flutter SDK (3.0+)
- Android Studio / VS Code
- Android Emulator veya fiziksel cihaz

### Adımlar

#### 1. Projeyi Klonla/İndir
```bash
cd acil_durum_asistani
```

#### 2. Bağımlılıkları Yükle
```bash
flutter pub get
```

#### 3. Cihazları Kontrol Et
```bash
flutter devices
```

#### 4. Uygulamayı Çalıştır
```bash
flutter run
```

#### 5. Test Et
```bash
flutter test
```

---

## 📱 EKRAN GÖRÜNTÜLERİ VE AÇIKLAMALAR

### 1. Ana Ekran (Home Screen)

**Görünüm:**
- Üstte: "Acil Durum Asistanı" başlığı
- Ortada: Acil durum ikonu
- Alt kısımda: 3 büyük buton
- En altta: "İnternet olmadan çalışır" bilgisi

**Butonlar:**
1. **🟠 DEPREM** (Turuncu)
   - Test butonu
   - SnackBar ile bilgi gösterir
   - Console'a log yazdırır

2. **🟢 GÜVENDEYİM** (Yeşil)
   - Güvendeyim mesajı oluşturur
   - Zamanı kaydeder
   - SafeModeScreen'e yönlendirir

3. **👨‍👩‍👧‍👦 YAKINLAR** (Mavi)
   - ContactsScreen'e yönlendirir

**Özel Özellik:**
- Son güvendeyim zamanı yeşil kutuda gösterilir

---

### 2. Yakınlar Ekranı (Contacts Screen)

**Üst Kısım:**
- Telefon numarası input alanı
- "EKLE" butonu
- Açıklama metni

**Alt Kısım:**
- Eklenen numaraların listesi
- Her numara için:
  - Avatar ikonu
  - Telefon numarası
  - Silme butonu

**Boş Durum:**
- İkon gösterimi
- "Henüz yakın eklenmedi" mesajı

**Validasyon:**
- Boş numara kontrolü
- Minimum 10 karakter kontrolü
- Duplicate kontrol (aynı numara eklenmez)

---

### 3. Güvendeyim Ekranı (Safe Mode Screen)

**Üst Kısım:**
- Yeşil onay ikonu
- "Güvendeyim Mesajı Oluşturuldu" başlığı

**Mesaj Kartı:**
- Beyaz arka plan
- Yeşil border
- Mesaj içeriği:
  ```
  Ben güvendeyim.
  Tarih: 07.01.2026
  Saat: 15:42
  ```

**Butonlar:**
1. **MESAJI KOPYALA** (Outlined)
   - Mesajı panoya kopyalar
   - Başarı bildirimi gösterir

2. **YAKINLARA GÖNDER** (Filled)
   - Test modunda çalışır
   - Console'a log yazdırır
   - Başarı bildirimi gösterir

**Yakınlar Bilgisi:**
- Mavi kutuda gösterilir
- Yakın sayısı
- Telefon numaraları listesi

**Bilgi Notu:**
- Sarı kutuda
- "İleride SMS entegrasyonu eklenecek"

---

## 🧪 TEST SENARYOLARI

### Test 1: Offline Çalışma
**Adımlar:**
1. Uygulamayı aç
2. Cihazın internetini kapat
3. Tüm özellikleri kullan

**Beklenen Sonuç:** ✅ Uygulama sorunsuz çalışır

---

### Test 2: Veri Kalıcılığı
**Adımlar:**
1. Yakın ekle
2. Güvendeyim butonuna bas
3. Uygulamayı kapat
4. Uygulamayı tekrar aç

**Beklenen Sonuç:** ✅ Veriler kaybolmaz

---

### Test 3: Güvendeyim Mesajı
**Adımlar:**
1. Ana ekranda "GÜVENDEYİM" butonuna bas
2. Mesaj ekranını kontrol et
3. Mesajı kopyala
4. Tarih/saat formatını kontrol et

**Beklenen Sonuç:** ✅ Doğru formatta mesaj oluşur

---

### Test 4: Yakın Yönetimi
**Adımlar:**
1. Yakınlar ekranına git
2. Geçersiz numara gir (örn: "123")
3. Geçerli numara gir (örn: "05551234567")
4. Aynı numarayı tekrar ekle
5. Numarayı sil

**Beklenen Sonuç:** 
- ✅ Geçersiz numara hata verir
- ✅ Geçerli numara eklenir
- ✅ Duplicate eklenmez
- ✅ Silme işlemi çalışır

---

### Test 5: Navigation
**Adımlar:**
1. Ana ekrandan Yakınlar'a git
2. Geri dön
3. Güvendeyim'e git
4. Geri dön

**Beklenen Sonuç:** ✅ Navigation sorunsuz çalışır

---

## 🔮 GELECEK GELİŞTİRMELER

### SEVİYE 2 (Orta Vadeli)

#### 1. UI İyileştirmeleri
- [ ] Dark mode desteği
- [ ] Animasyonlar
- [ ] Daha zengin ikonlar
- [ ] Özel font kullanımı

#### 2. Veri Yönetimi
- [ ] Güvendeyim geçmişi
- [ ] Yakın grupları
- [ ] Veri export/import

---

### SEVİYE 3 (Uzun Vadeli)

#### 1. SMS Entegrasyonu
**Paket:** `flutter_sms` veya `telephony`

**Özellikler:**
- Otomatik SMS gönderimi
- Toplu SMS
- Gönderim durumu takibi

**Örnek Kod:**
```dart
await sendSMS(
  message: message,
  recipients: contacts,
);
```

#### 2. Konum Servisi
**Paket:** `geolocator`

**Özellikler:**
- GPS koordinatları alma
- Konum mesaja ekleme
- Google Maps linki

**Mesaj Formatı:**
```
Ben güvendeyim.
Tarih: 07.01.2026
Saat: 15:42
Konum: https://maps.google.com/?q=41.0082,28.9784
```

#### 3. AFAD Entegrasyonu
**API:** AFAD Deprem API

**Özellikler:**
- Gerçek zamanlı deprem verileri
- Otomatik bildirim
- Deprem haritası

#### 4. Acil Durum Rehberi
**İçerik:**
- Deprem anında yapılacaklar
- Acil telefon numaraları
- İlk yardım bilgileri
- Toplanma alanları

#### 5. Push Notification
**Paket:** `firebase_messaging`

**Özellikler:**
- Deprem uyarıları
- Yakınlardan bildirim
- Acil durum duyuruları

---

## 📊 PROJE İSTATİSTİKLERİ

| Metrik | Değer |
|--------|-------|
| Toplam Kod Satırı | ~800 |
| Dart Dosyası | 7 |
| Ekran Sayısı | 3 |
| Servis Sayısı | 3 |
| Bağımlılık Sayısı | 2 |
| Geliştirme Süresi | 1 gün |
| Test Coverage | Widget testleri |

---

## 💡 TEKNİK ZORLUKLAR VE ÇÖZÜMLER

### Zorluk 1: Offline Veri Saklama
**Problem:** Verilerin internet olmadan saklanması  
**Çözüm:** shared_preferences ile key-value storage  
**Alternatifler:** Hive, SQLite

### Zorluk 2: Tarih/Saat Formatı
**Problem:** Türkçe tarih formatı  
**Çözüm:** intl paketi ile DateFormat  
**Örnek:** `DateFormat('dd.MM.yyyy')`

### Zorluk 3: State Yönetimi
**Problem:** Ekranlar arası veri senkronizasyonu  
**Çözüm:** Navigator callback ile refresh  
**Kod:** `.then((_) => _loadLastSafeTime())`

### Zorluk 4: Validasyon
**Problem:** Telefon numarası kontrolü  
**Çözüm:** Basit string length kontrolü  
**İyileştirme:** Regex ile format kontrolü

---

## 🎓 ÖĞRENİLEN KONULAR

1. **Flutter Temelleri**
   - StatefulWidget vs StatelessWidget
   - Lifecycle methods (initState, dispose)
   - BuildContext kullanımı

2. **Navigation**
   - MaterialPageRoute
   - Navigator.push/pop
   - Callback ile veri aktarımı

3. **Veri Saklama**
   - shared_preferences
   - Async/await kullanımı
   - Future handling

4. **UI/UX**
   - Material Design 3
   - Custom widgets
   - Responsive layout

5. **Best Practices**
   - Service pattern
   - Separation of concerns
   - Clean code principles

---

## 🏆 SONUÇ

### Başarılan Hedefler
✅ Offline-first mimari  
✅ Basit ve kullanışlı UI  
✅ Veri kalıcılığı  
✅ Hata toleransı  
✅ Genişletilebilir yapı  

### Projenin Değeri
Bu proje, **gerçek hayatta kullanılabilir** bir MVP (Minimum Viable Product) olarak tasarlanmıştır. Deprem gibi acil durumlarda hayat kurtarıcı olabilecek bir uygulamanın temelini oluşturmaktadır.

### Gelecek Vizyonu
SMS, konum ve AFAD entegrasyonları ile bu uygulama, Türkiye'de yaygın olarak kullanılabilecek bir **acil durum platformu** haline gelebilir.

---

## 📞 İLETİŞİM

**Proje Türü:** Final Projesi  
**Ders:** Mobil Uygulama Geliştirme  
**Platform:** Flutter  
**Tarih:** 07.01.2026

---

**NOT:** Bu rapor, projenin teknik ve akademik sunumu için hazırlanmıştır.
