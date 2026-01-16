# 🔊 SES DOSYASI KURULUM REHBERİ

## ✅ ŞU ANDA DURUM:

- ✅ Ses altyapısı hazır
- ✅ Kod güncellenmiş
- ⚠️ Ses dosyası eklenmeli

Ses dosyası **olmasa bile** uygulama çalışır (sadece titreşim kullanır).

---

## 📥 SES DOSYASI İNDİRME

### 🎯 Önerilen Ücretsiz Siteler:

#### 1. **Pixabay** ⭐ (EN KOLAY - Hesapsız)
```
https://pixabay.com/sound-effects/search/siren/
```
- Hesap gerektirmez
- Direkt indir
- MP3 formatında

#### 2. **Freesound.org** (Kaliteli)
```
https://freesound.org/search/?q=emergency+siren
```
- Ücretsiz hesap gerekir (1 dakika)
- "Emergency Siren" arayın
- MP3 olarak indirin

#### 3. **Mixkit** (Profesyonel)
```
https://mixkit.co/free-sound-effects/alarm/
```
- Hesapsız
- Yüksek kalite
- MP3 formatında

---

## 📝 KURULUM ADIMLARI:

### Adım 1: Ses İndir
1. Yukarıdaki sitelerden birini ziyaret edin
2. "siren", "emergency siren" veya "alarm" arayın
3. Beğendiğiniz sesi **MP3** formatında indirin

### Adım 2: Dosyayı Yeniden Adlandır
```
İndirilen dosya: "emergency_siren_123.mp3"
Yeni ad: "siren.mp3"
```

### Adı 3: Doğru Klasöre Kopyala
```
Hedef: acil_durum_asistani/assets/sounds/siren.mp3
```

Dosya yapısı:
```
acil_durum_asistani/
├── assets/
│   └── sounds/
│       └── siren.mp3  ← BURAYA
├── lib/
├── android/
└── pubspec.yaml
```

### Adım 4: Projeyi Yenile
VS Code terminal:
```bash
flutter pub get
```

### Adım 5: Uygulamayı Yeniden Başlat
```bash
# Hot reload yeterli DEĞİL
# Tam yeniden başlatın:
flutter run
# VEYA VS Code'da: Shift+F5 (Stop) → F5 (Start)
```

---

## ✅ TEST:

1. Uygulamayı başlatın
2. "GÜVENDE DEĞİLİM" butonuna basın
3. "🚨 YÜKSEK SESLİ SİREN" butonuna basın
4. ✅ Ses duyulmalı!

---

## 🛠️ SORUN GİDERME:

### Ses Çalmıyor?

**1. Dosya adını kontrol edin:**
```
✅ Doğru: siren.mp3
❌ Yanlış: siren (1).mp3
❌ Yanlış: emergency_siren.mp3
```

**2. Dosya konumunu kontrol edin:**
```bash
# PowerShell'de kontrol:
Test-Path "assets/sounds/siren.mp3"
# True dönmeli
```

**3. Pubspec.yaml kontrol:**
```yaml
flutter:
  assets:
    - assets/sounds/
```

**4. Tam yeniden başlatın:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 💡 ÖNERİLER:

### İdeal Ses Özellikleri:
- **Format:** MP3 veya WAV
- **Süre:** 2-5 saniye (döngüde çalar)
- **Bit rate:** 128-192 kbps
- **Ses seviyesi:** Yüksek ama distortion yok

### Önerilem Aramalar:
- "emergency siren"
- "police siren"
- "ambulance siren"
- "alarm siren"
- "warning siren"

---

## 📌 ÖNEMLI NOTLAR:

1. ⚠️ **Ses dosyası OLMADAN da uygulama çalışır**
   - Sadece titreşim kullanır
   - "Ses dosyası eklenmemiş" mesajı çıkar

2. ✅ **Windows/Bilgisayarda ses çalar**
   - Artık bilgisayarda da siren sesi duyulur!

3. 📱 **Android'de hem ses hem titreşim**
   - Telefonda tam deneyim

4. 🔁 **Ses döngüde çalar**
   - Durdur butonuna basana kadar

---

## 🎵 HANGİ SESİ SEÇMELİ?

### Kısa Siren (Önerilen):
- 2-3 saniye
- Hızlı tekrar eder
- Dikkat çekici

### Uzun Siren:
- 4-5 saniye
- Daha az tekrar
- Daha yumuşak

**Öneri:** 2-3 saniyelik kısa bir siren seçin!

---

## 🆘 YARDIM:

Ses dosyası eklerken sorun yaşıyorsanız:
1. Dosya adı tam olarak `siren.mp3` olmalı
2. Klasör: `assets/sounds/` olmalı
3. `flutter pub get` çalıştırılmalı
4. Uygulama **tamamen yeniden başlatılma** (hot reload değil)

---

**Not:** Bu README dosyası `assets/sounds/` klasöründedir.
