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
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final int score = quizProvider.score;
    final int correct = quizProvider.correctCount;
    final int total = quizProvider.totalQuestions;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hasil Akhir Kuis',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: const [
            ThemeToggleButton(),
            SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: AdaptiveContainer(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Ilustrasi Hasil
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      maxWidth: 240,
                    ),
                    child: Image.asset(
                      'assets/images/questions.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Kartu Skor Utama
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                AppColors.primaryDark.withOpacity(0.8),
                                const Color(0xFF312E81),
                              ]
                            : [
                                AppColors.primary,
                                AppColors.primaryDark,
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Kerja Bagus, ${quizProvider.userName}!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Lingkaran Skor
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$score',
                                style: const TextStyle(
                                  fontFamily: AppStyles.primaryFont,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '/ 100',
                                style: TextStyle(
                                  fontFamily: AppStyles.primaryFont,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          quizProvider.performanceStatus,
                          style: const TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Statistik Rincian
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Benar',
                          value: '$correct',
                          color: AppColors.success,
                          icon: Icons.check_circle_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Salah',
                          value: '${quizProvider.incorrectCount}',
                          color: AppColors.error,
                          icon: Icons.cancel_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Akurasi',
                          value: '${((correct / total) * 100).round()}%',
                          color: AppColors.primary,
                          icon: Icons.pie_chart_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Bagian Review Soal & Jawaban
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pembahasan & Rincian Soal',
                      style: AppStyles.headingSmall(
                        isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    quizProvider.questions.length,
                    (qIndex) {
                      final question = quizProvider.questions[qIndex];
                      final userAnswer =
                          quizProvider.getSelectedAnswer(qIndex);
                      final bool isCorrect =
                          userAnswer == question.correctAnswerIndex;

                      return _buildReviewTile(
                        context,
                        questionNumber: qIndex + 1,
                        question: question,
                        userAnswerIndex: userAnswer,
                        isCorrect: isCorrect,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol Aksi
                  AppButton(
                    text: 'Ulangi Kuis',
                    icon: Icons.refresh_rounded,
                    type: ButtonType.primary,
                    onPressed: () {
                      quizProvider.restartQuiz(keepUserName: true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Kembali ke Menu Utama',
                    icon: Icons.home_rounded,
                    type: ButtonType.secondary,
                    onPressed: () {
                      quizProvider.restartQuiz(keepUserName: false);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
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

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppStyles.primaryFont,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          Text(
            title,
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
    );
  }

  Widget _buildReviewTile(
    BuildContext context, {
    required int questionNumber,
    required Question question,
    required int? userAnswerIndex,
    required bool isCorrect,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const labels = ['A', 'B', 'C', 'D'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect
              ? AppColors.success.withOpacity(0.5)
              : AppColors.error.withOpacity(0.5),
        ),
      ),
      child: ExpansionTile(
        shape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCorrect
                ? (isDark
                    ? AppColors.success.withOpacity(0.2)
                    : AppColors.successLight)
                : (isDark
                    ? AppColors.error.withOpacity(0.2)
                    : AppColors.errorLight),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCorrect ? Icons.check : Icons.close,
            size: 18,
            color: isCorrect ? AppColors.success : AppColors.error,
          ),
        ),
        title: Text(
          'Soal #$questionNumber',
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        subtitle: Text(
          question.question,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: 12,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question.question,
              style: AppStyles.bodyLarge(
                isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),
          // Rincian Jawaban
          ...List.generate(question.options.length, (optIndex) {
            final isUserChoice = userAnswerIndex == optIndex;
            final isTargetCorrect = question.correctAnswerIndex == optIndex;

            Color optColor = isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary;
            FontWeight weight = FontWeight.w400;
            Widget? trailingIcon;

            if (isTargetCorrect) {
              optColor = AppColors.success;
              weight = FontWeight.w700;
              trailingIcon = const Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: AppColors.success,
              );
            } else if (isUserChoice) {
              optColor = AppColors.error;
              weight = FontWeight.w700;
              trailingIcon = const Icon(
                Icons.cancel_rounded,
                size: 16,
                color: AppColors.error,
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    '${labels[optIndex]}. ',
                    style: TextStyle(
                      fontFamily: AppStyles.primaryFont,
                      fontSize: 13,
                      fontWeight: weight,
                      color: optColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      question.options[optIndex],
                      style: TextStyle(
                        fontFamily: AppStyles.primaryFont,
                        fontSize: 13,
                        fontWeight: weight,
                        color: optColor,
                      ),
                    ),
                  ),
                  if (trailingIcon != null) trailingIcon,
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          // Pembahasan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    question.explanation,
                    style: TextStyle(
                      fontFamily: AppStyles.primaryFont,
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
