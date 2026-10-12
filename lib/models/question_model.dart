class Question {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuestionBank {
  static const List<Question> questions = [
    Question(
      id: 1,
      question:
          'Widget apa di Flutter yang digunakan untuk komponen UI yang tampilannya tidak pernah berubah saat runtime?',
      options: [
        'StatefulWidget',
        'StatelessWidget',
        'InheritedWidget',
        'AnimatedWidget',
      ],
      correctAnswerIndex: 1,
      explanation:
          'StatelessWidget adalah widget yang immutable (tidak memiliki state internal yang berubah-ubah setelah di-build).',
    ),
    Question(
      id: 2,
      question:
          'File apa yang digunakan untuk mendaftarkan dependensi paket, font, dan aset gambar pada proyek Flutter?',
      options: [
        'build.gradle',
        'pubspec.yaml',
        'analysis_options.yaml',
        'AndroidManifest.xml',
      ],
      correctAnswerIndex: 1,
      explanation:
          'pubspec.yaml adalah file konfigurasi utama proyek Flutter untuk metadata, package dependencies, dan aset.',
    ),
    Question(
      id: 3,
      question:
          'Fitur Flutter apa yang memungkinkan pengembang melihat perubahan kode secara instan tanpa kehilangan state aplikasi?',
      options: [
        'Hot Restart',
        'Full Rebuild',
        'Hot Reload',
        'Cold Boot',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Hot Reload menyuntikkan kode baru langsung ke VM Dart tanpa me-reset state aplikasi yang sedang berjalan.',
    ),
    Question(
      id: 4,
      question:
          'Method lifecycle apa yang pertama kali dipanggil saat State object dari StatefulWidget dibuat?',
      options: [
        'build()',
        'initState()',
        'didUpdateWidget()',
        'dispose()',
      ],
      correctAnswerIndex: 1,
      explanation:
          'initState() dipanggil tepat satu kali saat State object pertama kali dimasukkan ke dalam widget tree.',
    ),
    Question(
      id: 5,
      question:
          'Package state management resmi yang direkomendasikan dan menggunakan konsep ChangeNotifier & Consumer adalah...',
      options: [
        'Redux',
        'Bloc',
        'Provider',
        'MobX',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Provider adalah wrapper di atas InheritedWidget yang menyederhanakan manajemen state dengan ChangeNotifier.',
    ),
    Question(
      id: 6,
      question:
          'Widget layout apa yang menyusun anak-anaknya (children) secara vertikal dari atas ke bawah?',
      options: [
        'Row',
        'Stack',
        'Wrap',
        'Column',
      ],
      correctAnswerIndex: 3,
      explanation:
          'Column menyusun list widget secara vertikal, sedangkan Row menyusunnya secara horizontal.',
    ),
    Question(
      id: 7,
      question:
          'Bagaimana cara mencegah widget Column atau Row mengalami pixel overflow saat konten melebihi ukuran layar?',
      options: [
        'Membungkus dengan SingleChildScrollView',
        'Mengubah ukuran margin menjadi 0',
        'Menggunakan Container kosong',
        'Menghapus semua padding',
      ],
      correctAnswerIndex: 0,
      explanation:
          'SingleChildScrollView memungkinkan seluruh konten dapat di-scroll saat melebihi viewport layar.',
    ),
    Question(
      id: 8,
      question:
          'Keyword apa di Dart yang digunakan untuk menandai variabel yang diinisialisasi nanti tetapi dijamin tidak null saat diakses?',
      options: [
        'const',
        'final',
        'late',
        'dynamic',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Keyword `late` digunakan untuk lazy initialization atau variabel non-nullable yang diisi setelah deklarasi.',
    ),
    Question(
      id: 9,
      question:
          'Widget apa yang menyediakan struktur visual dasar Material Design seperti AppBar, Drawer, dan SnackBar?',
      options: [
        'MaterialApp',
        'Scaffold',
        'SafeArea',
        'ThemeData',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Scaffold mengimplementasikan layout dasar visual standar Material Design.',
    ),
    Question(
      id: 10,
      question:
          'Method apa yang dipanggil untuk membersihkan resource seperti controller, timer, atau listener saat widget dihapus dari tree?',
      options: [
        'deactivate()',
        'destroy()',
        'dispose()',
        'terminate()',
      ],
      correctAnswerIndex: 2,
      explanation:
          'dispose() dipanggil ketika objek State dihapus permanen dari widget tree untuk mencegah memory leak.',
    ),
  ];
}
