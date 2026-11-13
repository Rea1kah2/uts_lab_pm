import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../providers/quiz_provider.dart';
import '../widgets/adaptive_container.dart';
import '../widgets/app_button.dart';
import '../widgets/option_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/theme_toggle_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  static const List<String> optionLabels = ['A', 'B', 'C', 'D'];

  void _confirmSubmit(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();
    final unanswered = quizProvider.unansweredCount;

    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor:
              isDark ? AppColors.darkSurface : AppColors.lightSurface,
          title: Text(
            'Kumpulkan Jawaban?',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          content: Text(
            unanswered > 0
                ? 'Masih ada $unanswered soal yang belum dijawab. Apakah kamu yakin ingin menyelesaikan kuis sekarang?'
                : 'Semua pertanyaan sudah kamu jawab. Kumpulkan sekarang untuk melihat skor akhir?',
            style: AppStyles.bodyLarge(
              isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Periksa Lagi',
                style: TextStyle(
                  fontFamily: AppStyles.primaryFont,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                quizProvider.submitQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Ya, Kumpulkan'),
            ),
          ],
        );
      },
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor:
              isDark ? AppColors.darkSurface : AppColors.lightSurface,
          title: Text(
            'Keluar dari Kuis?',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          content: Text(
            'Progres kuis kamu tersimpan, namun kamu akan kembali ke halaman utama.',
            style: AppStyles.bodyLarge(
              isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Lanjutkan Kuis'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text(
                'Keluar',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final currentQ = quizProvider.currentQuestion;
    final selectedAnswerIndex =
        quizProvider.getSelectedAnswer(quizProvider.currentIndex);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _confirmExit(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => _confirmExit(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Kuis Pemrograman Mobile',
                style: AppStyles.headingSmall(
                  isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              Text(
                'Peserta: ${quizProvider.userName}',
                style: TextStyle(
                  fontFamily: AppStyles.primaryFont,
                  fontSize: 12,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
          actions: const [
            ThemeToggleButton(),
            SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: AdaptiveContainer(
            child: Column(
              children: [
                // Indikator Progres
                QuizProgressBar(
                  currentIndex: quizProvider.currentIndex,
                  totalQuestions: quizProvider.totalQuestions,
                ),
                const SizedBox(height: 14),

                // Daftar nomor soal (Quick Navigation Chips)
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: quizProvider.totalQuestions,
                    itemBuilder: (context, index) {
                      final bool isCurrent =
                          index == quizProvider.currentIndex;
                      final bool isAnswered =
                          quizProvider.isQuestionAnswered(index);

                      Color chipBg;
                      Color chipText;
                      BorderSide chipBorder = BorderSide.none;

                      if (isCurrent) {
                        chipBg = AppColors.primary;
                        chipText = Colors.white;
                      } else if (isAnswered) {
                        chipBg = isDark
                            ? AppColors.success.withOpacity(0.2)
                            : AppColors.successLight;
                        chipText = AppColors.success;
                        chipBorder = BorderSide(
                          color: AppColors.success.withOpacity(0.4),
                          width: 1,
                        );
                      } else {
                        chipBg = isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface;
                        chipText = isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary;
                        chipBorder = BorderSide(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => quizProvider.goToQuestion(index),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: chipBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: chipBorder.color,
                                width: chipBorder.width,
                              ),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontFamily: AppStyles.primaryFont,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: chipText,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Area Pertanyaan & Pilihan Ganda (Scrollable & Responsive)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Pertanyaan
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.lightSurface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder,
                            ),
                          ),
                          child: Text(
                            currentQ.question,
                            style: AppStyles.bodyLarge(
                              isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Opsi Jawaban
                        ...List.generate(
                          currentQ.options.length,
                          (optIndex) {
                            final label = optionLabels[optIndex];
                            final text = currentQ.options[optIndex];
                            final isSelected =
                                selectedAnswerIndex == optIndex;

                            return OptionCard(
                              label: label,
                              text: text,
                              isSelected: isSelected,
                              onTap: () {
                                quizProvider.selectAnswer(optIndex);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // Tombol Navigasi Bawah
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    children: [
                      // Tombol Sebelumnya
                      if (!quizProvider.isFirstQuestion) ...[
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            text: 'Sebelumnya',
                            icon: Icons.chevron_left_rounded,
                            type: ButtonType.secondary,
                            onPressed: () => quizProvider.goToPrevious(),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],

                      // Tombol Selanjutnya / Selesai
                      Expanded(
                        flex: quizProvider.isFirstQuestion ? 2 : 1,
                        child: AppButton(
                          text: quizProvider.isLastQuestion
                              ? 'Kumpulkan Kuis'
                              : 'Selanjutnya',
                          icon: quizProvider.isLastQuestion
                              ? Icons.check_circle_outline_rounded
                              : Icons.chevron_right_rounded,
                          type: ButtonType.primary,
                          onPressed: () {
                            if (quizProvider.isLastQuestion) {
                              _confirmSubmit(context);
                            } else {
                              quizProvider.goToNext();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
