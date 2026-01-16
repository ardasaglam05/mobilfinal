# 🚀 HIZLI BAŞLANGIÇ REHBERİ

## ⚡ 5 Dakikada Başla

### 1️⃣ Projeyi Aç
```bash
cd acil_durum_asistani
```

### 2️⃣ Bağımlılıkları Yükle
```bash
flutter pub get
```

### 3️⃣ Çalıştır
```bash
flutter run
```

**İşte bu kadar! Uygulama çalışıyor. 🎉**

---

## 📱 İlk Kullanım

### Adım 1: Yakın Ekle
1. Ana ekranda **"YAKINLAR"** butonuna bas
2. Telefon numarası gir (örn: 05551234567)
3. **"EKLE"** butonuna bas
4. Geri dön (← butonu)

### Adım 2: Güvendeyim Mesajı Oluştur
1. Ana ekranda **"GÜVENDEYİM"** butonuna bas
2. Mesaj otomatik oluşturuldu!
3. **"MESAJI KOPYALA"** ile kopyala
4. **"YAKINLARA GÖNDER"** ile test et

### Adım 3: Offline Test
1. Cihazın internetini kapat
2. Uygulamayı kapat ve tekrar aç
3. Tüm özellikleri dene
4. Veriler hala duruyor! ✅

---

## 🧪 Test Et

### Widget Testlerini Çalıştır
```bash
flutter test
```

### Kodu Analiz Et
```bash
flutter analyze
```

### APK Oluştur (Android)
```bash
flutter build apk --release
```

APK dosyası: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📂 Proje Yapısı

```
lib/
├── main.dart                    # 🚪 Giriş noktası
├── screens/                     # 📱 Ekranlar
│   ├── home_screen.dart        # Ana ekran
│   ├── contacts_screen.dart    # Yakınlar
│   └── safe_mode_screen.dart   # Güvendeyim
└── services/                    # ⚙️ Servisler
    ├── safe_status_service.dart
    ├── message_service.dart
    └── contacts_service.dart
```

---

## 🔧 Sorun Giderme

### Problem: `flutter pub get` hata veriyor
**Çözüm:**
```bash
flutter clean
flutter pub get
```

### Problem: Uygulama açılmıyor
**Çözüm:**
```bash
flutter doctor
```
Eksik bileşenleri yükle.

### Problem: Emulator yok
**Çözüm:**
```bash
flutter emulators
flutter emulators --launch <emulator_id>
```

### Problem: Hot reload çalışmıyor
**Çözüm:**
- Uygulamayı kapat
- `flutter run` ile tekrar başlat

---

## 📚 Daha Fazla Bilgi

- **README.md** - Genel bilgi
- **PROJE_RAPORU.md** - Detaylı teknik rapor
- **SUNUM_METNI.md** - Sunum için rehber

---

## 💡 İpuçları

1. **Hot Reload:** Kod değişikliğinden sonra `r` tuşuna bas
2. **Hot Restart:** `R` tuşuna bas (büyük harf)
3. **Quit:** `q` tuşuna bas
4. **Debug Console:** Android Studio'da Logcat'i aç

---

## 🎯 Sonraki Adımlar

1. ✅ Uygulamayı çalıştır
2. ✅ Özellikleri test et
3. ✅ Offline modunu dene
4. ⬜ Kodu incele
5. ⬜ Özelleştir
6. ⬜ Katkıda bulun

---

## 🤝 Katkıda Bulun

1. Fork et
2. Feature branch oluştur (`git checkout -b feature/amazing`)
3. Commit et (`git commit -m 'Add amazing feature'`)
4. Push et (`git push origin feature/amazing`)
5. Pull Request aç

---

## 📞 Yardım

Sorun mu yaşıyorsun?
- GitHub Issues aç
- Dokümantasyonu oku
- Flutter Discord'a sor

---

**Kolay gelsin! 🚀**
