import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class OptionCard extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color normalBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color selectedBg = isDark
        ? AppColors.primary.withOpacity(0.2)
        : AppColors.primaryLight.withOpacity(0.15);

    final Color normalBorder = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    const Color selectedBorder = AppColors.primary;

    final Color normalLabelBg = isDark ? AppColors.darkBorder : const Color(0xFFF1F5F9);
    const Color selectedLabelBg = AppColors.primary;

    final Color normalLabelText =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    const Color selectedLabelText = Colors.white;

    final Color textColor = isSelected
        ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected ? selectedBg : normalBg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? selectedBorder : normalBorder,
                width: isSelected ? 2.0 : 1.2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Label box (A, B, C, D)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? selectedLabelBg : normalLabelBg,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily: AppStyles.primaryFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? selectedLabelText : normalLabelText,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Option text
                Expanded(
                  child: Text(
                    text,
                    style: AppStyles.bodyLarge(textColor).copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Checkmark / radio indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : normalBorder,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
