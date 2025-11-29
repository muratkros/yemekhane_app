#  Yemekhane Otomasyon Sistemi

Bu proje, kurum yemekhanesindeki haftalık/aylık yemek listesini otomatik olarak takip eden ve çalışanlara mobil uygulama üzerinden bildiren bir otomasyon sistemidir.

##  Özellikler

- **Otomatik Güncelleme:** Python botu, Excel dosyasından günün yemeğini okur.
- **Bulut Entegrasyonu:** Veriler anlık olarak Firebase Realtime Database'e işlenir.
- **Hafta Sonu Modu:** Hafta sonları sistem otomatik olarak "Yemek Yok" bildirimi geçer.
- **Mobil Uygulama:** Flutter ile geliştirilen Android uygulaması sayesinde menü cepten takip edilir.

##  Kullanılan Teknolojiler

- **Backend:** Python (Pandas, Firebase Admin SDK)
- **Veritabanı:** Google Firebase Realtime Database
- **Mobil:** Flutter (Dart)
- **Veri Kaynağı:** Microsoft Excel

##  Nasıl Çalışır?

1. Yönetici, `yemek_listesi.xlsx` dosyasına yemekleri girer.
2. `baslat.bat` dosyası (veya Windows Görev Zamanlayıcı) Python botunu tetikler.
3. Bot, o günün tarihine ait yemeği bulur ve buluta gönderir.
4. Kullanıcılar uygulamayı açtığında güncel menüyü görür.

---
*Geliştirici: muratkros*
