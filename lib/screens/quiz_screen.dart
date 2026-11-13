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
            'Udah Yakin Nih? 🤔',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          content: Text(
            unanswered > 0
                ? 'Masih ada $unanswered soal yang belum lo jawab nih. Mau kumpulin sekarang atau periksa lagi?'
                : 'Semua soal udah lo jawab mantap! Kumpulin sekarang buat intip skor lo?',
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
              child: const Text('Ya, Kumpulin! 🚀'),
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
            'Batalan Kuis? 🛑',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          content: Text(
            'Progres jawaban lo di topik ini bakal ilang kalo lo balik ke halaman awal. Yakin mau cabut?',
            style: AppStyles.bodyLarge(
              isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Lanjut Kuis'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text(
                'Cabut Aja',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'web':
        return const Color(0xFFF59E0B); // Amber
      case 'flutter':
        return const Color(0xFF0284C7); // Sky blue
      case 'ios':
        return const Color(0xFF8B5CF6); // Purple
      case 'android':
        return const Color(0xFF10B981); // Emerald
      default:
        return AppColors.primary;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category) {
      case 'web':
        return '🌐';
      case 'flutter':
        return '💙';
      case 'ios':
        return '🍎';
      case 'android':
        return '🤖';
      default:
        return '⚡';
    }
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
          title: Text(
            'PilihDong',
            style: AppStyles.headingMedium(
              isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Kembali',
            onPressed: () => _confirmExit(context),
          ),
          actions: const [
            ThemeToggleButton(),
            SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: AdaptiveContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Header Info Atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          quizProvider.userName.isNotEmpty
                              ? quizProvider.userName
                              : 'Player',
                          style: TextStyle(
                            fontFamily: AppStyles.primaryFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Text(
                        quizProvider.selectedCategoryTitle,
                        style: const TextStyle(
                          fontFamily: AppStyles.primaryFont,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                QuizProgressBar(
                  currentIndex: quizProvider.currentIndex,
                  totalQuestions: quizProvider.totalQuestions,
                ),
                const SizedBox(height: 14),

                // Quick Navigation Chips
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

                // Area Pertanyaan & Pilihan Ganda
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Pertanyaan dengan Tag Kategori
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badge Kategori Soal
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(currentQ.category)
                                      .withOpacity(isDark ? 0.2 : 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getCategoryColor(currentQ.category)
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  '${_getCategoryIcon(currentQ.category)} ${currentQ.categoryLabel}',
                                  style: TextStyle(
                                    fontFamily: AppStyles.primaryFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: _getCategoryColor(currentQ.category),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Teks Pertanyaan
                              Text(
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
                            ],
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
                              ? 'Kumpulin Jawaban 🚀'
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
