import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../providers/quiz_provider.dart';
import '../widgets/adaptive_container.dart';
import '../widgets/app_button.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final quizProvider = context.read<QuizProvider>();
    if (quizProvider.userName.isNotEmpty) {
      _nameController.text = quizProvider.userName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      context.read<QuizProvider>().setUserName(name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz PM Lab',
          style: AppStyles.headingMedium(
            isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: AdaptiveContainer(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // Ilustrasi dinamis menyesuaikan orientasi dan layar
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenSize.height * 0.28,
                      maxWidth: 320,
                    ),
                    child: Image.asset(
                      'assets/images/online_test.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Judul & Tagline
                  Text(
                    'Uji Kemampuan Flutter Kamu!',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingLarge(
                      isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kuis Pilihan Ganda seputar Dasar Pemrograman Mobile, Widget, Lifecycle, dan State Management.',
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyLarge(
                      isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Info Kartu Kuis
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem(
                          context,
                          icon: Icons.help_outline_rounded,
                          title: '10 Soal',
                          subtitle: 'Pilihan Ganda',
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                        _buildInfoItem(
                          context,
                          icon: Icons.timer_outlined,
                          title: 'Fleksibel',
                          subtitle: 'Bebas Durasi',
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                        _buildInfoItem(
                          context,
                          icon: Icons.grade_outlined,
                          title: 'Skala 100',
                          subtitle: 'Skor Akhir',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Input Nama Pengguna
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Masukkan Nama Kamu',
                      style: AppStyles.headingSmall(
                        isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _startQuiz(),
                    style: TextStyle(
                      fontFamily: AppStyles.primaryFont,
                      fontSize: 15,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Contoh: M. Ariel Afriza',
                      hintStyle: TextStyle(
                        fontFamily: AppStyles.primaryFont,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.primary,
                      ),
                      filled: true,
                      fillColor:
                          isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.8,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.error,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.error,
                          width: 1.8,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama tidak boleh kosong untuk memulai kuis';
                      }
                      if (value.trim().length < 2) {
                        return 'Nama minimal terdiri dari 2 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol Mulai
                  AppButton(
                    text: 'Mulai Kuis Sekarang',
                    icon: Icons.play_arrow_rounded,
                    onPressed: _startQuiz,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: 11,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
