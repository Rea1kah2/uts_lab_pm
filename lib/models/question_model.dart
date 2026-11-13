class Question {
  final int id;
  final String category; // 'web', 'flutter', 'ios', 'android'
  final String categoryLabel;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.id,
    required this.category,
    required this.categoryLabel,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuestionCategory {
  final String id;
  final String title;
  final String subtitle;
  final String icon;

  const QuestionCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class QuestionBank {
  static const List<QuestionCategory> categories = [
    QuestionCategory(
      id: 'all',
      title: 'Campur Aja',
      subtitle: 'Tantangan semua topik!',
      icon: '🎲',
    ),
    QuestionCategory(
      id: 'web',
      title: 'Web Dev',
      subtitle: 'HTML, CSS, JS & Modern Web',
      icon: '🌐',
    ),
    QuestionCategory(
      id: 'flutter',
      title: 'Flutter & Dart',
      subtitle: 'Widget, State & Cross-platform',
      icon: '💙',
    ),
    QuestionCategory(
      id: 'ios',
      title: 'iOS Dev',
      subtitle: 'Swift, SwiftUI & Apple Ecosystem',
      icon: '🍎',
    ),
    QuestionCategory(
      id: 'android',
      title: 'Android Native',
      subtitle: 'Kotlin, Compose & Architecture',
      icon: '🤖',
    ),
  ];

  static const List<Question> allQuestions = [
    // ==========================================
    // 🌐 WEB PROGRAMMING (5 Soal)
    // ==========================================
    Question(
      id: 101,
      category: 'web',
      categoryLabel: 'Web Programming',
      question:
          'Di CSS Flexbox, properti apa yang dipakai buat mengatur perataan elemen sepanjang sumbu utama (main axis)?',
      options: [
        'align-items',
        'justify-content',
        'align-content',
        'flex-direction',
      ],
      correctAnswerIndex: 1,
      explanation:
          'justify-content ngatur posisi item di main axis (horizontal kalau flex-direction row). Kalau align-items ngaturnya di cross axis!',
    ),
    Question(
      id: 102,
      category: 'web',
      categoryLabel: 'Web Programming',
      question:
          'Apa perbedaan mendasar antara `==` (abstract equality) dan `===` (strict equality) di JavaScript?',
      options: [
        'Tidak ada bedanya, cuma preferensi linter',
        '`===` ngecek nilai sekaligus tipe data tanpa konversi tipe otomatis',
        '`==` lebih cepat eksekusinya dibanding `===`',
        '`===` hanya bisa dipakai untuk tipe data primitif number',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`===` (strict equality) gak bakal ngelakuin type coercion. Jadi `"5" === 5` itu false, sedangkan `"5" == 5` itu true karena dipaksa dikonversi tipenya.',
    ),
    Question(
      id: 103,
      category: 'web',
      categoryLabel: 'Web Programming',
      question:
          'HTTP status code mana yang paling tepat untuk menandakan bahwa request berhasil dan ada resource baru yang sukses dibuat di server?',
      options: [
        '200 OK',
        '201 Created',
        '204 No Content',
        '304 Not Modified',
      ],
      correctAnswerIndex: 1,
      explanation:
          '201 Created adalah kode standar REST API pas lo berhasil nge-POST sesuatu dan resource barunya beneran kesimpan di database.',
    ),
    Question(
      id: 104,
      category: 'web',
      categoryLabel: 'Web Programming',
      question:
          'Mekanisme apa di JavaScript runtime yang bertugas menangani callback asynchronous dari Event Queue ke Call Stack saat stack kosong?',
      options: [
        'Garbage Collector',
        'Event Loop',
        'JIT Compiler',
        'Thread Pool Worker',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Event Loop selalu mantau Call Stack. Begitu stack kosong, dia bakal ngambil tugas pertama dari Task Queue / Microtask Queue buat dieksekusi.',
    ),
    Question(
      id: 105,
      category: 'web',
      categoryLabel: 'Web Programming',
      question:
          'Tag semantic HTML5 mana yang paling pas buat ngebungkus konten utama yang independen dan reusable (misal: artikel blog atau postingan)?',
      options: [
        '<section>',
        '<article>',
        '<main>',
        '<aside>',
      ],
      correctAnswerIndex: 1,
      explanation:
          '<article> khusus dirancang buat konten utuh yang bisa berdiri sendiri dan didistribusikan ulang (seperti postingan forum, artikel blog, atau kartu berita).',
    ),

    // ==========================================
    // 💙 FLUTTER & DART (5 Soal)
    // ==========================================
    Question(
      id: 201,
      category: 'flutter',
      categoryLabel: 'Flutter & Dart',
      question:
          'Widget Flutter mana yang dipakai untuk UI yang tampilannya dinamis dan punya state internal yang bisa berubah sewaktu-waktu?',
      options: [
        'StatelessWidget',
        'StatefulWidget',
        'InheritedWidget',
        'RenderObjectWidget',
      ],
      correctAnswerIndex: 1,
      explanation:
          'StatefulWidget punya companion object State yang nampung mutable state dan bisa trigger re-render lewat method `setState()`.',
    ),
    Question(
      id: 202,
      category: 'flutter',
      categoryLabel: 'Flutter & Dart',
      question:
          'File apa yang jadi pusat konfigurasi proyek Flutter untuk mendaftarkan packages, fonts, dan aset gambar?',
      options: [
        'build.gradle',
        'pubspec.yaml',
        'analysis_options.yaml',
        'AndroidManifest.xml',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`pubspec.yaml` adalah file manifesto utama tempat lo nambahin dependensi dari pub.dev, aset gambar, dan konfigurasi font custom.',
    ),
    Question(
      id: 203,
      category: 'flutter',
      categoryLabel: 'Flutter & Dart',
      question:
          'Fitur andalan Flutter apa yang memungkinkan developer melihat perubahan kode UI dalam hitungan sub-detik tanpa nge-reset state aplikasi?',
      options: [
        'Cold Reboot',
        'Hot Reload',
        'Hot Restart',
        'JIT Refresh',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Hot Reload menyuntikkan source code baru langsung ke Dart VM yang sedang jalan tanpa bikin state aplikasi hilang. Kalau mau restart dari awal baru pakai Hot Restart!',
    ),
    Question(
      id: 204,
      category: 'flutter',
      categoryLabel: 'Flutter & Dart',
      question:
          'Di package Provider, method atau class apa yang biasanya di-extend oleh class business logic agar widget bisa mendengarkan perubahannya?',
      options: [
        'StreamController',
        'ChangeNotifier',
        'StateNotifier',
        'ObserverPattern',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`ChangeNotifier` dari Flutter foundation nyediain method `notifyListeners()` buat ngabarin semua widget Consumer / Provider kalau ada data yang berubah.',
    ),
    Question(
      id: 205,
      category: 'flutter',
      categoryLabel: 'Flutter & Dart',
      question:
          'Keyword apa di Dart yang digunakan buat nandain bahwa suatu variabel non-nullable bakal diisi nilainya nanti sebelum pertama kali diakses?',
      options: [
        'const',
        'late',
        'final',
        'dynamic',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`late` ngasih tau analyzer bahwa lo janji bakal nginisialisasi variabel itu sebelum dipakai, jadi Dart gak bakal rewel error null-check saat kompilasi.',
    ),

    // ==========================================
    // 🍎 IOS DEVELOPMENT (5 Soal)
    // ==========================================
    Question(
      id: 301,
      category: 'ios',
      categoryLabel: 'iOS Development',
      question:
          'Di bahasa Swift, apa perbedaan mendasar deklarasi variabel menggunakan `let` vs `var`?',
      options: [
        '`let` untuk variabel konstan (immutable), sedangkan `var` bisa diubah (mutable)',
        '`let` hanya untuk tipe data teks, `var` untuk angka',
        '`var` otomatis dialokasikan di heap, `let` di stack',
        'Keduanya sama persis, `let` adalah sintaks lama Objective-C',
      ],
      correctAnswerIndex: 0,
      explanation:
          'Di Swift, `let` dipakai buat bikin konstanta yang nilainya gak bisa di-reassign setelah diisi. Sedangkan `var` sifatnya mutable alias bisa diganti nilainya.',
    ),
    Question(
      id: 302,
      category: 'ios',
      categoryLabel: 'iOS Development',
      question:
          'Framework UI deklaratif modern dari Apple yang dirilis tahun 2019 dan menyusun UI menggunakan Swift code langsung (tanpa Storyboard) adalah...',
      options: [
        'UIKit',
        'SwiftUI',
        'AppKit',
        'Interface Builder',
      ],
      correctAnswerIndex: 1,
      explanation:
          'SwiftUI adalah framework deklaratif modern dari Apple yang bikin pembuatan UI di iOS, macOS, watchOS, dan tvOS jadi super ringkas berbasis state.',
    ),
    Question(
      id: 303,
      category: 'ios',
      categoryLabel: 'iOS Development',
      question:
          'Apa nama mekanisme manajemen memori otomatis yang digunakan oleh runtime Swift untuk melacak dan menghapus instance class?',
      options: [
        'Tracing Garbage Collection',
        'ARC (Automatic Reference Counting)',
        'Manual Retain Release',
        'Mark and Sweep',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Swift pake ARC (Automatic Reference Counting). ARC bakal ngitung jumlah referensi aktif ke suatu instance; begitu referensinya 0, memorinya langsung dibebasin.',
    ),
    Question(
      id: 304,
      category: 'ios',
      categoryLabel: 'iOS Development',
      question:
          'Di SwiftUI, property wrapper apa yang paling pas dipakai untuk menyimpan state lokal sederhana yang hanya dimiliki oleh satu View tertentu?',
      options: [
        '@EnvironmentObject',
        '@State',
        '@ObservedObject',
        '@Binding',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`@State` dipakai khusus buat nilai lokal sederhana yang jadi milik private view itu sendiri. Kalau nilainya berubah, SwiftUI otomatis me-render ulang view-nya.',
    ),
    Question(
      id: 305,
      category: 'ios',
      categoryLabel: 'iOS Development',
      question:
          'Tanda baca apa yang digunakan di Swift untuk menandai bahwa suatu tipe data bersifat Optional (bisa bernilai atau bernilai `nil`)?',
      options: [
        'Tanda seru (`!`)',
        'Tanda tanya (`?`)',
        'Tanda pagar (`#`)',
        'Tanda persen (`%`)',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Tanda tanya `?` di belakang tipe (misal: `String?`) nandain tipe data Optional yang bisa nampung string atau `nil`. Kalau tanda seru `!` dipakai buat force unwrapping.',
    ),

    // ==========================================
    // 🤖 ANDROID NATIVE (5 Soal)
    // ==========================================
    Question(
      id: 401,
      category: 'android',
      categoryLabel: 'Android Native',
      question:
          'Di Android Activity Lifecycle, callback apa yang dipanggil saat Activity mulai terlihat oleh pengguna dan siap menerima interaksi input?',
      options: [
        'onCreate()',
        'onStart()',
        'onResume()',
        'onPause()',
      ],
      correctAnswerIndex: 2,
      explanation:
          '`onResume()` dipanggil tepat saat activity berada di foreground dan siap berinteraksi langsung dengan user. Pas layar mulai ketutup sebagian, dia masuk `onPause()`.',
    ),
    Question(
      id: 402,
      category: 'android',
      categoryLabel: 'Android Native',
      question:
          'Toolkit UI deklaratif modern resmi dari Google untuk membangun antarmuka native Android menggunakan bahasa Kotlin adalah...',
      options: [
        'XML Layout Editor',
        'Jetpack Compose',
        'Flutter Android',
        'Android Data Binding',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Jetpack Compose adalah toolkit modern Google berbasis Kotlin yang menggantikan paradigma XML layout lama menjadi kode UI deklaratif yang jauh lebih ekspresif.',
    ),
    Question(
      id: 403,
      category: 'android',
      categoryLabel: 'Android Native',
      question:
          'Komponen arsitektur Android Jetpack apa yang dirancang untuk menyimpan dan mengelola data UI agar tidak hilang saat terjadi configuration change (misal rotasi layar)?',
      options: [
        'BroadcastReceiver',
        'ViewModel',
        'Service',
        'ContentProvider',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`ViewModel` bertahan melewati lifecycle recreation Activity saat rotasi layar terjadi, sehingga data UI lo tetap aman tanpa perlu fetch ulang.',
    ),
    Question(
      id: 404,
      category: 'android',
      categoryLabel: 'Android Native',
      question:
          'File manifesto XML utama apa yang wajib ada di setiap aplikasi Android untuk mendaftarkan izin (permissions), komponen activity, dan konfigurasi paket?',
      options: [
        'build.gradle.kts',
        'AndroidManifest.xml',
        'settings.gradle',
        'proguard-rules.pro',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`AndroidManifest.xml` adalah cetak biru aplikasi Android yang ngedefinisikan izin (permission internet, kamera, dll), nama package, launcher activity, dan service.',
    ),
    Question(
      id: 405,
      category: 'android',
      categoryLabel: 'Android Native',
      question:
          'Di bahasa Kotlin, keyword apa yang digunakan untuk mendeklarasikan variabel yang nilainya read-only (hanya bisa diisi sekali / immutable)?',
      options: [
        'var',
        'val',
        'const val',
        'let',
      ],
      correctAnswerIndex: 1,
      explanation:
          '`val` (value) di Kotlin bersifat read-only mirip `final` di Java. Sedangkan `var` (variable) nilainya mutable dan bisa di-reassign.',
    ),
  ];

  /// Mengambil daftar soal berdasarkan kategori yang dipilih
  static List<Question> getQuestionsByCategory(String categoryId) {
    if (categoryId == 'all') {
      return List.unmodifiable(allQuestions);
    }
    final filtered =
        allQuestions.where((q) => q.category == categoryId).toList();
    return List.unmodifiable(filtered);
  }
}
