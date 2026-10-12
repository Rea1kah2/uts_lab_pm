# 📱 Quiz PM Lab - Aplikasi Kuis Pilihan Ganda

Proyek Ujian Tengah Semester (UTS) Praktikum Pemrograman Mobile  
**Unit IKLC Program Studi Ilmu Komputer, Fasilkom-TI, Universitas Sumatera Utara**

---

## 👤 1. Identitas Mahasiswa

| Informasi | Keterangan |
| :--- | :--- |
| **Nama** | M. Ariel Afriza |
| **NIM** | 241401073 |
| **Program Studi** | S1 Ilmu Komputer |
| **Laboratorium** | Lab Pemrograman Mobile 5 |
| **Asisten Lab** | Muhammad Dzakwan Attaqiy (DZK) |

---

## 💡 2. Informasi Aplikasi

### Nama Aplikasi
**Quiz PM Lab** (*Mobile Programming Quiz App*)

### Deskripsi Singkat
**Quiz PM Lab** adalah aplikasi kuis interaktif pilihan ganda berbasis Flutter yang dirancang untuk menguji pemahaman mahasiswa terkait konsep dasar Pemrograman Mobile, hierarki Widget, Lifecycle, State Management, dan bahasa pemrograman Dart. Aplikasi ini mengutamakan antarmuka yang bersih, modern, responsif, dan bebas overflow di berbagai orientasi maupun dimensi layar.

### Fitur-Fitur Utama

1. **Input & Validasi Nama Pengguna:**
   - Memastikan nama pengguna terisi dengan valid sebelum kuis dimulai.
   - Nama pengguna tersimpan secara reaktif di seluruh halaman aplikasi.

2. **Kuis Pilihan Ganda Dinamis:**
   - Menggunakan model data Dart (`Question` & `QuestionBank`), tanpa struktur file terpisah per pertanyaan.
   - Pilihan ganda interaktif dengan visual feedback instan saat opsi dipilih.
   - Quick Navigation Chips untuk berpindah langsung ke nomor soal mana pun.

3. **State Management Tahan Rotasi (Provider):**
   - Menggunakan `QuizProvider` dengan `ChangeNotifier`.
   - Progres jawaban, posisi pertanyaan, dan skor **tidak akan hilang** saat layar perangkat dirotasi (portrait/landscape) atau saat navigasi antarhalaman.

4. **Kalkulasi Skor & Evaluasi Hasil:**
   - Skor otomatis dihitung dengan skala 0 - 100.
   - Rincian ringkas: Jumlah Benar, Jumlah Salah, dan Persentase Akurasi.
   - Fitur **Pembahasan & Rincian Soal (Review Accordion)**: Menampilkan kunci jawaban benar beserta penjelasan edukatif tiap soal.

5. **Fitur Bonus - Dual Theme (Light & Dark Mode):**
   - Dilengkapi `ThemeProvider` untuk beralih instan antara Mode Terang dan Mode Gelap via tombol toggle di AppBar.

6. **Fitur Bonus - Adaptive & Responsive Layout:**
   - Menggunakan komponen `AdaptiveContainer` dengan `BoxConstraints`, `SingleChildScrollView`, serta `LayoutBuilder` / `MediaQuery` sehingga tampilan tetap simetris dan rapi saat dibuka di layar tablet maupun browser (Web).

7. **Komponen Reusable Widget:**
   - Seluruh elemen UI yang berulang telah dipisahkan ke dalam folder `lib/widgets/`:
     - `AppButton`: Tombol dinamis dengan varian primary, secondary, dan outline.
     - `OptionCard`: Kartu pilihan ganda responsif dengan indikator centang.
     - `QuizProgressBar`: Indikator progres pengerjaan kuis real-time.
     - `AdaptiveContainer`: Kontainer pembatas lebar maksimal untuk adaptasi tablet/web.
     - `ThemeToggleButton`: Tombol animasi pengganti tema gelap/terang.

---

## 📂 3. Struktur Proyek

```text
lib/
├── constants/
│   ├── app_colors.dart         # Palet warna Light & Dark mode
│   └── app_styles.dart         # Tipografi font Plus Jakarta Sans
├── models/
│   └── question_model.dart     # Model Question & Bank Soal Kuis
├── providers/
│   ├── quiz_provider.dart      # State manajemen kuis (nama, jawaban, skor)
│   └── theme_provider.dart     # State manajemen Light/Dark mode
├── widgets/
│   ├── adaptive_container.dart # Container responsif mobile, tablet & web
│   ├── app_button.dart         # Reusable button dengan aneka style
│   ├── option_card.dart        # Reusable pilihan ganda kuis
│   ├── progress_bar.dart       # Reusable progress bar
│   └── theme_toggle_button.dart# Reusable tombol switch tema
├── screens/
│   ├── welcome_screen.dart     # Halaman input nama & pembuka
│   ├── quiz_screen.dart        # Halaman pengerjaan kuis
│   └── result_screen.dart      # Halaman hasil & pembahasan soal
└── main.dart                   # Root MultiProvider & inisialisasi aplikasi
```

---

## 🎨 4. Dokumentasi & Aset

### Kredit Sumber Aset
- **Ilustrasi Vektor:** [Storyset by Freepik](https://storyset.com/) (`Online test-bro.png` dan `Questions-bro.png`).
- **Font Kustom:**
  - [Plus Jakarta Sans](https://fonts.google.com/specimen/Plus+Jakarta+Sans) oleh Gumpita Rahayu & Tokotype (SIL Open Font License).
  - [Poppins](https://fonts.google.com/specimen/Poppins) oleh Indian Type Foundry (SIL Open Font License).
- **Ikon:** Material Icons bawaan Flutter Framework.

### Mockup & Desain Prototype
- **Link Mockup / Figma Prototype:** [Tautan Desain Figma](https://www.figma.com/) *(opsional / dapat disesuaikan)*

### Tangkapan Layar (Screenshots)

| Halaman Utama (Light Mode) | Halaman Kuis (Light Mode) | Halaman Hasil (Light Mode) |
| :---: | :---: | :---: |
| *(Screenshot Welcome Screen)* | *(Screenshot Quiz Screen)* | *(Screenshot Result Screen)* |

| Halaman Utama (Dark Mode) | Halaman Kuis (Dark Mode) | Halaman Hasil (Dark Mode) |
| :---: | :---: | :---: |
| *(Screenshot Welcome Dark)* | *(Screenshot Quiz Dark)* | *(Screenshot Result Dark)* |

---

## 🛠️ 5. Cara Menjalankan Proyek

1. **Pastikan Flutter SDK terpasang:**
   ```bash
   flutter doctor
   ```

2. **Clone repositori dan masuk ke direktori:**
   ```bash
   git clone https://github.com/Rea1kah2/uts_lab_pm.git
   cd quiz_pm_lab
   ```

3. **Unduh dependensi paket:**
   ```bash
   flutter pub get
   ```

4. **Jalankan aplikasi:**
   ```bash
   # Di Emulator Android / iOS atau Chrome
   flutter run
   ```
