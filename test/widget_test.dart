import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pilih_dong/main.dart';
import 'package:pilih_dong/models/question_model.dart';
import 'package:pilih_dong/providers/quiz_provider.dart';
import 'package:pilih_dong/providers/theme_provider.dart';

void main() {
  group('QuestionBank Tests', () {
    test('QuestionBank provides correct question count per category', () {
      expect(QuestionBank.getQuestionsByCategory('web').length, 5);
      expect(QuestionBank.getQuestionsByCategory('flutter').length, 5);
      expect(QuestionBank.getQuestionsByCategory('ios').length, 5);
      expect(QuestionBank.getQuestionsByCategory('android').length, 5);
      expect(QuestionBank.getQuestionsByCategory('all').length, 20);
    });

    test('QuizProvider category selection updates active question list', () {
      final provider = QuizProvider();
      expect(provider.totalQuestions, 20); // Default 'all'
      expect(provider.selectedCategory, 'all');

      provider.setCategory('web');
      expect(provider.selectedCategory, 'web');
      expect(provider.totalQuestions, 5);

      provider.setCategory('flutter');
      expect(provider.selectedCategory, 'flutter');
      expect(provider.totalQuestions, 5);
    });
  });

  group('Widget Smoke Tests', () {
    testWidgets('PilihDong initial screen smoke test with category selector',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => QuizProvider()),
          ],
          child: const PilihDongApp(),
        ),
      );

      // Verify WelcomeScreen elements are present
      expect(find.text('PilihDong'), findsOneWidget);
      expect(
        find.text('Seberapa Jago Coding Lo? Buktiin di Sini!'),
        findsOneWidget,
      );
      expect(find.text('Pilih Topik Kuis'), findsOneWidget);
      expect(find.text('Campur Aja'), findsOneWidget);
      expect(find.text('Web Dev'), findsOneWidget);
      expect(find.text('Flutter & Dart'), findsOneWidget);
      expect(find.text('iOS Dev'), findsOneWidget);
      expect(find.text('Android Native'), findsOneWidget);
      expect(find.text('Gas, Mulai Kuis! 🚀'), findsOneWidget);
    });
  });
}
