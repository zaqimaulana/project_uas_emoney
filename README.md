# Project UAS E-Money (Dompet Kampus Global)

## 📖 Deskripsi Aplikasi
Aplikasi **Dompet Kampus Global** adalah platform e-money terpadu yang dibangun untuk memfasilitasi transaksi keuangan di lingkungan kampus. Proyek ini terdiri dari dua bagian utama:
1. **Frontend**: Antarmuka pengguna bernama `dompet_kampus_global`.
2. **Backend**: RESTful API dan servis yang melayani aplikasi, berada di direktori `be-emoney`.

Selain itu, aplikasi ini juga terhubung atau memiliki referensi dengan ekosistem aplikasi e-commerce yang dapat dilihat pada repositori berikut:
👉 **[Projek UTS Mobile Store](https://github.com/zaqimaulana/projek_uts_mobile_store.git)**

## 🏗️ Arsitektur Aplikasi
Aplikasi ini menggunakan arsitektur *Client-Server*:
- **Client**: Berjalan di sisi pengguna (aplikasi/web) untuk menangani UI/UX dan interaksi (*frontend*).
- **Server**: Mengelola logika bisnis, autentikasi, serta menyediakan *endpoint* REST API (*backend*).
- **Database**: Tempat penyimpanan persisten untuk data pengguna, saldo, dompet digital, dan riwayat transaksi pengguna.

## 🚀 Cara Menjalankan Proyek

### Menjalankan Backend (`be-emoney`)
1. Buka terminal dan masuk ke direktori backend:
   ```bash
   cd be-emoney
   ```
2. Lakukan instalasi dependensi (sesuaikan dengan package manager/framework yang digunakan, misal: `npm install` atau `composer install`).
3. Lakukan konfigurasi *Environment Variables*. (Salin file `.env.example` ke `.env` dan sesuaikan kredensial database).
4. Jalankan server backend (misal: `npm run dev`, `php artisan serve`, atau perintah serupa).

### Menjalankan Frontend (`dompet_kampus_global`)
1. Buka terminal baru dan masuk ke direktori frontend:
   ```bash
   cd dompet_kampus_global
   ```
2. Lakukan instalasi dependensi (misal: `flutter pub get` jika menggunakan Flutter, atau `npm install` jika berbasis web).
3. Jalankan aplikasi (misal: `flutter run` atau `npm start`).

## 📦 Daftar Dependensi Utama
*(Catatan: Silakan sesuaikan dependensi di bawah ini dengan stack teknologi pasti dari proyek Anda)*
- **Backend (`be-emoney`)**:
  - Web Framework (misal: Express.js, Laravel, Go, dll)
  - Database Driver (misal: MySQL, PostgreSQL, MongoDB)
- **Frontend (`dompet_kampus_global`)**:
  - UI Framework (misal: Flutter SDK, React, Vue, dll)
  - State Management & HTTP Client (Dio, Provider/GetX, Axios, dll)

## 📸 Screenshot Aplikasi
*(Silakan ganti tanda `#` dan teks dengan link gambar screenshot aplikasi yang sebenarnya)*

| Halaman Login | Halaman Beranda / Saldo | Riwayat Transaksi |
|:---:|:---:|:---:|
| ![Screenshot Login](#) | ![Screenshot Beranda](#) | ![Screenshot Riwayat](#) |

## 🎥 Link Video Presentasi YouTube
Tonton video penjelasan arsitektur dan demonstrasi fitur aplikasi pada tautan berikut:

👉 **[Link Video Presentasi YouTube Anda di Sini]**
