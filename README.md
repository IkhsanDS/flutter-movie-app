# 🎬 Flutter Movie App

Aplikasi pencarian dan eksplorasi film modern yang dibuat menggunakan **Flutter**, dengan dukungan **TMDB API** dan **Firebase**.

---

## 📌 Tentang Aplikasi

Flutter Movie App adalah aplikasi film dengan tampilan modern dan arsitektur modular yang memungkinkan pengguna untuk:

- Melihat film trending
- Mendapatkan rekomendasi sesuai genre pilihan
- Mencari film
- Melihat detail film & trailer
- Menyimpan film favorit
- Menikmati animasi dan UI yang clean

Dibangun menggunakan Flutter + GetX + Firebase + TMDB API.

---

## ✨ Fitur Utama

### 🔐 Autentikasi
- Login & Register menggunakan Firebase Authentication
- Alur: Splash → Login → Onboarding → Home

### 🎭 Rekomendasi Personal
- Pemilihan genre saat onboarding
- Rekomendasi film berdasarkan genre yang dipilih pengguna

### 🔍 Pencarian Film
- Fitur Search berdasarkan judul film
- Menggunakan API TMDB
- Hasil pencarian real-time

### 🎥 Kategori Film
- 🔥 Trending Movies
- ⭐ Top Rated Movies
- 🎬 Now Playing Movies
- 📄 See All dengan Pagination
- 🔄 Pull to Refresh

### ❤️ Favorit / Watchlist
- Tambah & hapus film favorit
- Data tersimpan di Cloud Firestore
- Update UI secara real-time
- Swipe untuk menghapus
- Tampilan grid seperti Netflix

### 📄 Detail Film
- Gambar backdrop
- Rating & tanggal rilis
- Sinopsis
- Trailer (YouTube)
- Tombol tambah ke favorit

### 🎨 UI / UX
- Tema gelap modern
- Animasi splash screen
- Card dengan sudut rounded
- Carousel horizontal elegan

---

## 🛠 Teknologi yang Digunakan

| Teknologi | Fungsi |
|------------|--------|
| Flutter | Framework UI |
| GetX | State Management & Routing |
| Firebase Auth | Autentikasi |
| Cloud Firestore | Database |
| TMDB API | Data Film |
| URL Launcher | Membuka Trailer |
| Flutter Dotenv | Keamanan API Key |
| Shimmer | Efek Loading |

---

## 📸 Screenshot

<p align="center">
  <img src="lib/assets/Screenshot/HOME.png" width="220">
  <img src="lib/assets/Screenshot/FAVORITE.png" width="220">
  <img src="lib/assets/Screenshot/DETAIL.png" width="220">
</p>

---

## 🔐 Konfigurasi Environment

Buat file `.env` di root project:

```
TMDB_API_KEY=your_api_key_here
```

Pastikan file `.env` sudah ditambahkan ke `.gitignore`.

---

## 🚀 Cara Menjalankan

### 1️⃣ Clone Repository

```
git clone https://github.com/IkhsanDs/flutter-movie-app.git
```

### 2️⃣ Install Dependency

```
flutter pub get
```

### 3️⃣ Setup Firebase

- Tambahkan `google-services.json` ke `android/app/`
- Tambahkan `GoogleService-Info.plist` ke `ios/Runner/`

### 4️⃣ Jalankan Aplikasi

```
flutter run
```

---

## 📂 Struktur Project

```
lib/
 ├── app/
 │   ├── modules/
 │   │   ├── auth/
 │   │   ├── home/
 │   │   ├── moviedetail/
 │   │   ├── favorite/
 │   │   ├── search/
 │   │   └── splash/
 │   ├── services/
 │   │   └── tmdb_service.dart
 │   ├── routes/
 │   └── theme/
```

---

## 📈 Arsitektur

- Struktur modular berbasis fitur
- State management menggunakan GetX
- UI reaktif dengan Obx()
- Pemisahan service, controller, dan tampilan

---

## 🔥 Pengembangan Selanjutnya

- [x] Autentikasi
- [x] Rekomendasi berbasis genre
- [x] Favorit dengan Firestore
- [x] Pagination (See All)
- [ ] Toggle Light / Dark Mode
- [ ] Animasi tambahan
- [ ] Publish ke Play Store

---

## 👨‍💻 Developer

Ikhsan Dwi Seto

---

## 📄 Lisensi

Project ini dibuat untuk keperluan pembelajaran dan portfolio.
