import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/question_model.dart';
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
    final quizProvider = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PilihDong',
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
                  // Ilustrasi Utama
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenSize.height * 0.24,
                      maxWidth: 280,
                    ),
                    child: Image.asset(
                      'assets/images/online_test.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Judul & Tagline Santai (Anti AI-Slop)
                  Text(
                    'Seberapa Jago Coding Lo? Buktiin di Sini!',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingLarge(
                      isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tebak-tebakan santai seputar Web, Flutter, Android, sampe iOS. Pilih topiknya, jawab soalnya, dan liat seberapa jago lo!',
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyLarge(
                      isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info Kartu Kuis Ringkas
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
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
                          icon: Icons.quiz_outlined,
                          title: '${quizProvider.totalQuestions} Soal',
                          subtitle: 'Pilihan Ganda',
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                        _buildInfoItem(
                          context,
                          icon: Icons.coffee_outlined,
                          title: 'Santai',
                          subtitle: 'Bebas Durasi',
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                        _buildInfoItem(
                          context,
                          icon: Icons.emoji_events_outlined,
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
                      'Siapa nama panggilan lo?',
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
                      hintText: 'Misal: Rian si Fullstack',
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
                      fillColor: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
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
                        return 'Isi nama dulu dong, biar skor lo gak anonim!';
                      }
                      if (value.trim().length < 2) {
                        return 'Nama minimal 2 karakter ya!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Category Selector (Pemilihan Topik)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pilih Topik Kuis',
                          style: AppStyles.headingSmall(
                            isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                        Text(
                          quizProvider.selectedCategoryTitle,
                          style: const TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryGrid(context, quizProvider, isDark),
                  const SizedBox(height: 28),

                  // Tombol Mulai Kuis
                  AppButton(
                    text: 'Gas, Mulai Kuis! 🚀',
                    icon: Icons.play_arrow_rounded,
                    onPressed: _startQuiz,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(
    BuildContext context,
    QuizProvider quizProvider,
    bool isDark,
  ) {
    return Column(
      children: QuestionBank.categories.map((category) {
        final bool isSelected = quizProvider.selectedCategory == category.id;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () {
              quizProvider.setCategory(category.id);
            },
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(isDark ? 0.2 : 0.1)
                    : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  width: isSelected ? 1.8 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    category.icon,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.title,
                          style: TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          category.subtitle,
                          style: TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 20,
                    )
                  else
                    Icon(
                      Icons.radio_button_unchecked_rounded,
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
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
            color:
                isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: 11,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
