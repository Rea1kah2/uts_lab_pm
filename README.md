# 📱 PilihDong - Aplikasi Kuis Pilihan Ganda Interaktif

Aplikasi kuis pilihan ganda modern berbasis **Flutter** yang responsif, adaptif di berbagai dimensi layar (Mobile, Tablet, Web), dan kaya fitur interaktif. Dirancang dengan prinsip Clean Code, Reusable Components, dan Robust State Management.

---

## 🚀 Fitur Unggulan

1. **Input & Validasi Nama Pengguna:**
   - Validasi nama pengguna sebelum kuis dimulai.
   - Nama pengguna tersimpan secara reaktif sepanjang sesi pengerjaan kuis.

2. **Kuis Pilihan Ganda Interaktif:**
   - Model data Dart modular (`Question` & `QuestionBank`).
   - Visual feedback instan saat opsi jawaban dipilih.
   - **Quick Navigation Chips**: Navigasi cepat berpindah langsung ke nomor soal tertentu kapan saja.

3. **State Management Tahan Rotasi (Provider):**
   - Menggunakan `QuizProvider` dengan pola `ChangeNotifier`.
   - Progres pengerjaan, jawaban yang dipilih, indeks soal, dan skor **tidak akan hilang** saat orientasi layar dirotasi (portrait/landscape) atau saat berpindah antarhalaman.

4. **Kalkulasi Skor Real-Time & Pembahasan Edukatif:**
   - Skor otomatis dihitung dengan skala 0 - 100.
   - Ringkasan hasil: Jumlah Benar, Jumlah Salah, dan Persentase Akurasi.
   - **Fitur Pembahasan & Rincian Soal (Review Accordion)**: Menampilkan kunci jawaban benar serta penjelasan edukatif komprehensif pada setiap soal.

5. **Dual Theme (Light & Dark Mode):**
   - Dilengkapi `ThemeProvider` untuk beralih instan antara Mode Terang dan Mode Gelap via tombol toggle animasi di AppBar.

6. **Adaptive & Responsive Layout:**
   - Dibangun menggunakan komponen `AdaptiveContainer` dengan `BoxConstraints`, `SingleChildScrollView`, serta `LayoutBuilder` / `MediaQuery`.
   - Tampilan tetap simetris, rapi, dan bebas *pixel overflow* saat dibuka di layar smartphone, tablet, maupun browser desktop.

7. **Komponen Reusable Widget:**
   - Seluruh elemen antarmuka yang berulang dipisahkan secara modular di `lib/widgets/`:
     - `AppButton`: Tombol dinamis beraneka varian (primary, secondary, outline).
     - `OptionCard`: Kartu pilihan ganda responsif dengan indikator centang/highlight.
     - `QuizProgressBar`: Indikator progres pengerjaan kuis interaktif real-time.
     - `AdaptiveContainer`: Kontainer pembatas lebar maksimal untuk adaptasi layar lebar.
     - `ThemeToggleButton`: Tombol switch tema gelap dan terang.

---

## 📂 Struktur Direktori Proyek

```text
lib/
├── constants/
│   ├── app_colors.dart         # Palet warna Light & Dark mode
│   └── app_styles.dart         # Tipografi font Plus Jakarta Sans
├── models/
│   └── question_model.dart     # Model Question & Bank Soal Kuis
├── providers/
│   ├── quiz_provider.dart      # State manajemen kuis (jawaban, skor, navigasi)
│   └── theme_provider.dart     # State manajemen tema Light/Dark mode
├── widgets/
│   ├── adaptive_container.dart # Container responsif mobile, tablet & web
│   ├── app_button.dart         # Reusable dynamic button
│   ├── option_card.dart        # Reusable card pilihan ganda
│   ├── progress_bar.dart       # Reusable progress bar
│   └── theme_toggle_button.dart# Reusable tombol switch tema
├── screens/
│   ├── welcome_screen.dart     # Halaman sambutan & input nama pengguna
│   ├── quiz_screen.dart        # Halaman pengerjaan kuis
│   └── result_screen.dart      # Halaman hasil & accordion pembahasan soal
└── main.dart                   # Root MultiProvider & inisialisasi aplikasi PilihDong
```

---

## 💻 Panduan Menjalankan di Lingkungan Lokal

### Prasyarat
- **Flutter SDK**: ^3.24.0 (disertai Dart SDK ^3.5.0)
- **Browser**: Google Chrome (untuk eksekusi Web)
- *Opsional*: Xcode (untuk macOS Desktop / iOS Simulator) atau Android SDK (untuk Android)

### 1. Unduh Dependensi
Buka terminal pada direktori proyek, lalu jalankan:
```bash
flutter pub get
```

### 2. Jalankan di Web (Google Chrome)
Rekomendasi tercepat untuk pengujian lokal:
```bash
flutter run -d chrome
```

### 3. Jalankan di Desktop (macOS)
```bash
flutter run -d macos
```

### 4. Jalankan di Android Emulator / Device Fisik
```bash
flutter run -d android
```

---

## 🧪 Pengujian & Analisis Kode

Jalankan pengujian widget dan unit test:
```bash
flutter test
```

Jalankan static analyzer untuk memastikan kode bersih dari error dan warning:
```bash
flutter analyze
```

---

## 🎨 Kredit Aset & Sumber Daya
- **Ilustrasi Vektor:** [Storyset by Freepik](https://storyset.com/) (`online_test.png` dan `questions.png`).
- **Font Kustom:**
  - [Plus Jakarta Sans](https://fonts.google.com/specimen/Plus+Jakarta+Sans) oleh Tokotype (SIL Open Font License).
  - [Poppins](https://fonts.google.com/specimen/Poppins) oleh Indian Type Foundry (SIL Open Font License).
- **Ikon:** Material Icons bawaan Flutter Framework.
