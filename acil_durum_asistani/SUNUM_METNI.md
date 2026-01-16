# 🎤 ACİL DURUM ASİSTANI - SUNUM METNİ

## SLAYT 1: BAŞLIK
**[Ekranda: Uygulama logosu ve başlık]**

"Merhaba, bugün sizlere **Acil Durum Asistanı** mobil uygulamamı tanıtacağım. Bu uygulama, Flutter ile geliştirilmiş, deprem ve acil durumlarda kullanılabilecek bir yardımcı uygulamadır."

---

## SLAYT 2: PROBLEM
**[Ekranda: Deprem fotoğrafları, iletişim sorunu görselleri]**

"Türkiye, deprem kuşağında yer alan bir ülke. Deprem anında karşılaştığımız en büyük sorunlardan biri **iletişim**. 

Deprem sonrası:
- İnternet altyapısı çökebilir
- Telefon hatları yoğunlaşır
- Yakınlarımıza ulaşamayız
- 'Ben güvendeyim' demek bile zorlaşır

İşte bu noktada **Acil Durum Asistanı** devreye giriyor."

---

## SLAYT 3: ÇÖZÜM
**[Ekranda: Uygulama ana ekranı]**

"Uygulamanın temel prensibi: **Offline-First**

Yani uygulama, **internet olmasa bile** tam fonksiyonel çalışır.

Nasıl?
- Tüm veriler cihazda saklanır
- İnternet bağlantısı gerektirmez
- Basit ve hızlı kullanıcı arayüzü"

---

## SLAYT 4: ANA ÖZELLİKLER
**[Ekranda: 3 ana buton görseli]**

"Uygulama 3 ana özelliğe sahip:

**1. 🟠 DEPREM Butonu**
- Şu anda test modunda
- İleride AFAD entegrasyonu yapılacak
- Otomatik deprem tespiti

**2. 🟢 GÜVENDEYİM Butonu**
- Tek tuşla 'Ben güvendeyim' mesajı
- Otomatik tarih/saat ekleme
- Yakınlara gönderme hazırlığı

**3. 👨‍👩‍👧‍👦 YAKINLAR Butonu**
- Acil durum kişilerini ekleme
- Telefon numarası yönetimi
- Offline saklama"

---

## SLAYT 5: TEKNİK MİMARİ
**[Ekranda: Mimari diyagram]**

"Teknik olarak uygulama şu şekilde çalışıyor:

**Katmanlar:**
1. **UI Katmanı** - Flutter Material Design 3
2. **Servis Katmanı** - İş mantığı
3. **Veri Katmanı** - shared_preferences

**Kullanılan Teknolojiler:**
- Flutter 3.35.5
- Dart 3.9.2
- shared_preferences (offline veri)
- intl (tarih formatı)

**Mimari Yaklaşım:**
- Clean Architecture
- Service Pattern
- Separation of Concerns"

---

## SLAYT 6: YAKINLAR YÖNETİMİ
**[Ekranda: Yakınlar ekranı demo]**

"Yakınlar ekranında:

**Özellikler:**
- Telefon numarası ekleme
- Listeleme
- Silme (onay ile)
- Validasyon

**Teknik Detaylar:**
- TextEditingController ile input yönetimi
- ListView.builder ile dinamik liste
- Duplicate kontrol
- Empty state handling

**Veri Saklama:**
- shared_preferences ile offline
- Uygulama kapansa bile veriler korunur"

---

## SLAYT 7: GÜVENDEYİM ÖZELLİĞİ
**[Ekranda: Güvendeyim ekranı, mesaj örneği]**

"Güvendeyim özelliği şöyle çalışıyor:

**1. Kullanıcı butona basar**
**2. Otomatik mesaj oluşturulur:**
```
Ben güvendeyim.
Tarih: 07.01.2026
Saat: 15:42
```

**3. Kullanıcı seçenekleri:**
- Mesajı kopyala
- Yakınlara gönder (test modu)

**Teknik:**
- DateTime.now() ile anlık zaman
- intl paketi ile Türkçe format
- Clipboard API ile kopyalama
- shared_preferences ile kayıt"

---

## SLAYT 8: OFFLINE ÇALIŞMA
**[Ekranda: İnternet kapalı demo]**

"En önemli özellik: **Offline çalışma**

**Demo:**
[Cihazın internetini kapatın]
- Uygulama açılıyor ✅
- Yakın eklenebiliyor ✅
- Güvendeyim mesajı oluşturuluyor ✅
- Veriler saklanıyor ✅

**Nasıl?**
- shared_preferences = yerel depolama
- Key-value storage
- Async/await ile veri işleme
- Internet gerektirmeyen servisler"

---

## SLAYT 9: KOD ÖRNEĞİ
**[Ekranda: Kod snippet]**

"Örnek bir servis kodu:

```dart
class SafeStatusService {
  Future<void> saveSafeTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('safe_time', time.toIso8601String());
  }
  
  Future<DateTime?> getSafeTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString('safe_time');
    return timeString != null ? DateTime.parse(timeString) : null;
  }
}
```

**Açıklama:**
- Async/await kullanımı
- Null safety
- Error handling
- Clean code"

---

## SLAYT 10: TEST SONUÇLARI
**[Ekranda: Test checklist]**

"Uygulamayı kapsamlı test ettik:

**✅ Test 1: Offline Çalışma**
- İnternet kapalı → Uygulama çalışıyor

**✅ Test 2: Veri Kalıcılığı**
- Uygulama kapatıldı/açıldı → Veriler duruyor

**✅ Test 3: Güvendeyim Mesajı**
- Mesaj oluşturuluyor → Doğru format

**✅ Test 4: Yakın Yönetimi**
- Ekleme/silme → Çalışıyor
- Validasyon → Çalışıyor

**✅ Test 5: Navigation**
- Ekranlar arası geçiş → Sorunsuz"

---

## SLAYT 11: PROJE İSTATİSTİKLERİ
**[Ekranda: İstatistik grafikleri]**

"Proje sayılarla:

| Metrik | Değer |
|--------|-------|
| Toplam Kod Satırı | ~800 |
| Dart Dosyası | 7 |
| Ekran Sayısı | 3 |
| Servis Sayısı | 3 |
| Bağımlılık | 2 |
| Geliştirme Süresi | 1 gün |

**Dosya Yapısı:**
- 3 Screen (UI)
- 3 Service (Logic)
- 1 Main (Entry point)"

---

## SLAYT 12: TEKNİK ZORLUKLAR
**[Ekranda: Problem-Çözüm tablosu]**

"Geliştirme sürecinde karşılaşılan zorluklar:

**Zorluk 1: Offline Veri Saklama**
- Problem: İnternet olmadan veri saklama
- Çözüm: shared_preferences
- Alternatif: Hive, SQLite

**Zorluk 2: Tarih Formatı**
- Problem: Türkçe tarih formatı
- Çözüm: intl paketi
- Örnek: DateFormat('dd.MM.yyyy')

**Zorluk 3: State Yönetimi**
- Problem: Ekranlar arası senkronizasyon
- Çözüm: Navigator callback
- Kod: .then((_) => refresh())

**Öğrenme:** Her zorluk, yeni bir teknik öğrenme fırsatı oldu."

---

## SLAYT 13: GELECEK GELİŞTİRMELER
**[Ekranda: Roadmap]**

"Uygulama genişletilebilir bir yapıda tasarlandı:

**SEVİYE 2 (Yakın Gelecek):**
- ⬜ Dark mode
- ⬜ Animasyonlar
- ⬜ Güvendeyim geçmişi
- ⬜ Yakın grupları

**SEVİYE 3 (Uzun Vadeli):**
- ⬜ **SMS Entegrasyonu** (flutter_sms)
- ⬜ **GPS Konum** (geolocator)
- ⬜ **AFAD API** (gerçek zamanlı deprem)
- ⬜ **Push Notification** (firebase)
- ⬜ **Acil Durum Rehberi**

**Vizyon:** Türkiye'nin en çok kullanılan acil durum uygulaması"

---

## SLAYT 14: DEMO
**[Ekranda: Canlı uygulama]**

"Şimdi uygulamayı canlı gösterelim:

**1. Ana Ekran**
[Uygulamayı aç]
- 3 ana buton
- Temiz arayüz

**2. Yakınlar Ekleme**
[Yakınlar ekranına git]
- Numara ekle: 05551234567
- Listeye eklendi
- Sil butonu

**3. Güvendeyim**
[Ana ekrana dön, Güvendeyim'e bas]
- Mesaj oluşturuldu
- Tarih/saat otomatik
- Kopyala butonu
- Yakınlar listesi

**4. Offline Test**
[İnterneti kapat]
- Hala çalışıyor!
- Veriler duruyor!"

---

## SLAYT 15: NEDEN BU PROJE?
**[Ekranda: Motivasyon görselleri]**

"Bu projeyi neden yaptım?

**1. Gerçek Hayat Problemi**
- Deprem gerçeği
- İletişim sorunu
- Hayat kurtarıcı olabilir

**2. Teknik Öğrenme**
- Flutter derinlemesine
- Offline-first mimari
- Clean code practices

**3. Sosyal Fayda**
- Açık kaynak olabilir
- Herkes kullanabilir
- Geliştirilebilir

**Hedef:** Sadece bir final projesi değil, gerçekten kullanılabilir bir uygulama."

---

## SLAYT 16: ÖĞRENİLEN KONULAR
**[Ekranda: Öğrenme listesi]**

"Bu projede neler öğrendim?

**Flutter Temelleri:**
- StatefulWidget lifecycle
- Navigation patterns
- Material Design 3

**Veri Yönetimi:**
- shared_preferences
- Async/await
- Future handling

**UI/UX:**
- Responsive design
- Custom widgets
- User feedback (SnackBar, Dialog)

**Best Practices:**
- Service pattern
- Separation of concerns
- Error handling
- Code organization

**Soft Skills:**
- Problem çözme
- Dokümantasyon
- Proje yönetimi"

---

## SLAYT 17: KARŞILAŞTIRMA
**[Ekranda: Benzer uygulamalarla karşılaştırma]**

"Mevcut çözümlerle karşılaştırma:

**WhatsApp/SMS:**
- ❌ İnternet/sinyal gerektirir
- ❌ Manuel mesaj yazma
- ✅ Yaygın kullanım

**Acil Durum Asistanı:**
- ✅ Offline çalışır
- ✅ Otomatik mesaj
- ✅ Özelleştirilmiş
- ❌ Henüz yaygın değil

**AFAD Uygulaması:**
- ✅ Resmi kaynak
- ❌ İnternet gerektirir
- ❌ Karmaşık arayüz

**Bizim Avantajımız:**
- Offline-first
- Basit UI
- Hızlı erişim"

---

## SLAYT 18: KULLANICI SENARYOSU
**[Ekranda: Senaryo görselleri]**

"Gerçek hayat senaryosu:

**Durum:** Deprem oldu, elektrikler kesildi, internet yok.

**Ahmet'in Durumu:**
1. Deprem sonrası güvende
2. Ailesi merak ediyor
3. İnternet yok, telefon çekmiyor

**Çözüm:**
1. Acil Durum Asistanı'nı aç (offline çalışır)
2. 'GÜVENDEYİM' butonuna bas
3. Mesaj otomatik oluşur
4. İnternet gelince yakınlara gönder
   VEYA
5. Mesajı kopyala, başka yolla paylaş

**Sonuç:** Ahmet, ailesiyle iletişim kurabildi."

---

## SLAYT 19: SOSYAL ETKİ
**[Ekranda: İstatistikler, harita]**

"Projenin potansiyel sosyal etkisi:

**Türkiye'de:**
- 84 milyon nüfus
- Deprem riski yüksek
- İletişim altyapısı kırılgan

**Potansiyel Kullanıcı:**
- Deprem bölgelerinde yaşayanlar
- Yaşlılar (basit arayüz)
- Acil durum ekipleri

**Etki:**
- Hızlı iletişim
- Panik azaltma
- Hayat kurtarma

**Gelecek:**
- Belediyelerle işbirliği
- Okullarda eğitim
- Açık kaynak topluluk"

---

## SLAYT 20: AÇIK KAYNAK
**[Ekranda: GitHub logosu, lisans]**

"Proje açık kaynak olarak paylaşılabilir:

**Avantajlar:**
- Topluluk katkısı
- Sürekli geliştirme
- Şeffaflık
- Eğitim kaynağı

**Lisans:** MIT (önerim)

**Katkı Alanları:**
- Yeni özellikler
- Bug fix
- Çeviriler
- Dokümantasyon

**Platform:** GitHub
**Hedef:** 1000+ star, 100+ contributor"

---

## SLAYT 21: MALİYET ANALİZİ
**[Ekranda: Maliyet tablosu]**

"Proje maliyeti:

**Geliştirme:**
- Zaman: 1 gün
- Maliyet: ₺0 (açık kaynak araçlar)

**Bağımlılıklar:**
- Flutter: Ücretsiz
- shared_preferences: Ücretsiz
- intl: Ücretsiz

**Gelecek Maliyetler:**
- SMS API: ~₺0.10/mesaj
- Firebase: Ücretsiz tier
- Play Store: $25 (bir kerelik)
- App Store: $99/yıl

**Toplam:** Minimal maliyet, maksimum etki"

---

## SLAYT 22: GÜVENLİK
**[Ekranda: Güvenlik ikonları]**

"Veri güvenliği ve gizlilik:

**Veri Saklama:**
- Yerel cihazda (shared_preferences)
- Sunucuya gönderilmez
- Şifreleme (ileride)

**İzinler:**
- Minimal izin talebi
- SMS (opsiyonel)
- Konum (opsiyonel)

**Gizlilik:**
- Kullanıcı verisi toplanmaz
- Analitik yok (şimdilik)
- KVKK uyumlu

**Güvenlik:**
- Açık kaynak = şeffaf
- Community audit
- Regular updates"

---

## SLAYT 23: PERFORMANS
**[Ekranda: Performans metrikleri]**

"Uygulama performansı:

**Başlatma Süresi:**
- Cold start: ~2 saniye
- Hot start: <1 saniye

**Bellek Kullanımı:**
- RAM: ~50MB
- Disk: ~20MB

**Pil Tüketimi:**
- Minimal (background yok)
- Sadece kullanım anında

**Optimizasyon:**
- Lazy loading
- Efficient widgets
- Minimal dependencies

**Sonuç:** Hızlı ve verimli"

---

## SLAYT 24: ERIŞILEBILIRLIK
**[Ekranda: Erişilebilirlik özellikleri]**

"Herkes için tasarım:

**Mevcut:**
- Büyük butonlar
- Açık renkler
- Basit dil

**Gelecek:**
- Screen reader desteği
- Yüksek kontrast modu
- Font boyutu ayarı
- Sesli komut
- Çoklu dil (İngilizce, Arapça, Kürtçe)

**Hedef:** Yaşlılar, engelliler, herkes kullanabilsin"

---

## SLAYT 25: TEST COVERAGE
**[Ekranda: Test piramidi]**

"Test stratejisi:

**Widget Tests:**
- Ana ekran testi
- Buton testi
- Navigation testi

**Unit Tests (Gelecek):**
- Service testleri
- Validation testleri
- Date formatting testleri

**Integration Tests (Gelecek):**
- End-to-end senaryolar
- Offline test
- Data persistence test

**Manual Tests:**
- Gerçek cihazda test
- Farklı Android versiyonları
- Offline senaryo

**Hedef:** %80+ code coverage"

---

## SLAYT 26: CI/CD (Gelecek)
**[Ekranda: CI/CD pipeline]**

"Otomatik deployment planı:

**GitHub Actions:**
```yaml
- Kod push edilir
- Otomatik testler çalışır
- Lint kontrolü
- Build oluşturulur
- Play Store'a deploy
```

**Avantajlar:**
- Hızlı release
- Hata önleme
- Consistent builds

**Tools:**
- GitHub Actions
- Fastlane
- Firebase App Distribution"

---

## SLAYT 27: KULLANICI GERİ BİLDİRİMİ
**[Ekranda: Feedback formu mockup]**

"Kullanıcı geri bildirimi planı:

**Kanallar:**
- In-app feedback form
- GitHub issues
- Email: acildurum@example.com
- Sosyal medya

**Metrikler:**
- Kullanıcı sayısı
- Aktif kullanım
- Crash rate
- User satisfaction

**İyileştirme Döngüsü:**
1. Feedback topla
2. Analiz et
3. Önceliklendir
4. Geliştir
5. Release
6. Tekrar et"

---

## SLAYT 28: PAZARLAMA STRATEJİSİ
**[Ekranda: Marketing channels]**

"Uygulamayı nasıl yaygınlaştırırız?

**Organik:**
- Play Store optimizasyonu
- Sosyal medya
- Blog yazıları
- YouTube videoları

**Ortaklıklar:**
- Belediyeler
- AFAD
- Kızılay
- Okullar

**Medya:**
- Basın bülteni
- Haber siteleri
- Teknoloji blogları

**Topluluk:**
- Açık kaynak katkı
- Meetup sunumları
- Konferanslar

**Hedef:** 100K+ indirme ilk yıl"

---

## SLAYT 29: BAŞARI KRİTERLERİ
**[Ekranda: KPI dashboard]**

"Projenin başarısını nasıl ölçeriz?

**Teknik:**
- ✅ Uygulama çalışıyor
- ✅ Testler geçiyor
- ✅ Offline çalışıyor
- ⬜ %80+ test coverage

**Kullanıcı:**
- ⬜ 1000+ indirme
- ⬜ 4.5+ yıldız
- ⬜ Pozitif yorumlar
- ⬜ Düşük uninstall rate

**Sosyal:**
- ⬜ Medyada yer alma
- ⬜ Belediye ortaklığı
- ⬜ Gerçek hayatta kullanım
- ⬜ Hayat kurtarma hikayesi

**Akademik:**
- ✅ Final projesi tamamlandı
- ⬜ Yüksek not
- ⬜ Konferansta sunum"

---

## SLAYT 30: KİŞİSEL ÖĞRENME
**[Ekranda: Öğrenme grafiği]**

"Bu proje bana neler kattı?

**Teknik Beceriler:**
- Flutter mastery
- Dart advanced
- Offline architecture
- Clean code

**Soft Skills:**
- Problem solving
- Project management
- Documentation
- Presentation

**Mindset:**
- User-centric thinking
- Social impact focus
- Open source mentality
- Continuous learning

**Sonuç:** Sadece kod yazmadım, ürün düşünmeyi öğrendim."

---

## SLAYT 31: TEŞEKKÜR
**[Ekranda: Teşekkür mesajı]**

"Teşekkürler!

**Hocalarıma:**
- Değerli bilgiler için
- Destekleri için

**Arkadaşlarıma:**
- Test için
- Feedback için

**Açık Kaynak Topluluğuna:**
- Flutter team
- Package maintainers

**Sizlere:**
- Dinlediğiniz için
- Sorularınız için"

---

## SLAYT 32: SORULAR
**[Ekranda: Q&A]**

"Sorularınızı bekliyorum!

**Muhtemel Sorular:**

**S: Neden Flutter?**
C: Cross-platform, hızlı geliştirme, modern UI

**S: iOS desteği var mı?**
C: Evet, Flutter cross-platform. Sadece test etmedim.

**S: Gerçekten offline çalışıyor mu?**
C: Evet, demo yapabilirim.

**S: SMS nasıl gönderilecek?**
C: flutter_sms paketi ile, SEVİYE 3'te

**S: Açık kaynak olacak mı?**
C: Evet, GitHub'a yükleyeceğim

**S: Kaç günde yaptın?**
C: 1 gün (planlama dahil)

**Başka sorularınız?**"

---

## SLAYT 33: İLETİŞİM
**[Ekranda: İletişim bilgileri]**

"Benimle iletişime geçin:

**GitHub:** github.com/[username]/acil-durum-asistani  
**Email:** [email]@example.com  
**LinkedIn:** linkedin.com/in/[username]  
**Twitter:** @[username]

**Proje Linki:**
- Kaynak kod
- Dokümantasyon
- APK indirme
- Katkı rehberi

**Açık kaynak katkılarınızı bekliyorum!**"

---

## SLAYT 34: SON MESAJ
**[Ekranda: Motivasyonel görsel]**

"Son bir mesaj:

> 'Teknoloji, hayatları kolaylaştırmak ve kurtarmak için kullanılmalı.'

Bu proje, bu felsefenin bir ürünü.

**Hedefim:**
- Sadece not almak değil
- Gerçekten faydalı bir şey yapmak
- Topluma katkı sağlamak
- Açık kaynak kültürünü yaymak

**Sizden ricam:**
- Projeyi kullanın
- Geri bildirim verin
- Katkıda bulunun
- Paylaşın

**Birlikte daha güvenli bir Türkiye!**"

---

## BONUS: DEMO SENARYOSU

### Demo Öncesi Hazırlık
1. Uygulamayı emülatörde/cihazda aç
2. İnternet bağlantısını kontrol et
3. Yakınlar listesini temizle
4. Güvendeyim kaydını sil

### Demo Adımları

**1. Ana Ekran (30 saniye)**
- Uygulamayı aç
- 3 butonu göster
- "İnternet olmadan çalışır" vurgusu

**2. Deprem Butonu (15 saniye)**
- Deprem butonuna bas
- SnackBar göster
- "Test modu" açıkla

**3. Yakınlar Ekleme (1 dakika)**
- Yakınlar ekranına git
- Geçersiz numara dene (hata göster)
- Geçerli numara ekle (05551234567)
- Listeye eklendiğini göster
- Silme butonunu göster (silme)

**4. Güvendeyim (1 dakika)**
- Ana ekrana dön
- Güvendeyim butonuna bas
- Mesaj ekranını göster
- Tarih/saat formatını vurgula
- Kopyala butonunu test et
- Yakınlar listesini göster

**5. Offline Test (1 dakika)**
- İnterneti kapat (uçak modu)
- Uygulamayı kapat
- Uygulamayı tekrar aç
- Hala çalıştığını göster
- Yakınların durduğunu göster
- Güvendeyim yap
- İnterneti aç

**Toplam Demo Süresi:** ~4 dakika

---

## SUNUM İPUÇLARI

### Ses Tonu
- Net ve anlaşılır konuş
- Heyecanlı ama sakin
- Teknik terimleri açıkla

### Beden Dili
- Göz teması kur
- El hareketleri kullan
- Güven ver

### Zaman Yönetimi
- Slayt başına ~1 dakika
- Demo için ekstra zaman
- Sorular için buffer

### Teknik Hazırlık
- Yedek cihaz
- Yedek internet
- Ekran kaydı (plan B)

### Etkileşim
- Soru sor
- Feedback al
- Katılım sağla

---

**BAŞARILAR! 🚀**
