import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_pm_lab/main.dart';
import 'package:quiz_pm_lab/providers/quiz_provider.dart';
import 'package:quiz_pm_lab/providers/theme_provider.dart';

void main() {
  testWidgets('Quiz App initial screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: const QuizApp(),
      ),
    );

    // Verify WelcomeScreen elements are present
    expect(find.text('Quiz PM Lab'), findsOneWidget);
    expect(find.text('Mulai Kuis Sekarang'), findsOneWidget);
  });
}
