import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pilih_dong/main.dart';
import 'package:pilih_dong/providers/quiz_provider.dart';
import 'package:pilih_dong/providers/theme_provider.dart';

void main() {
  testWidgets('PilihDong initial screen smoke test', (WidgetTester tester) async {
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
    expect(find.text('Uji Kemampuanmu Bersama PilihDong!'), findsOneWidget);
    expect(find.text('Mulai Kuis Sekarang'), findsOneWidget);
  });
}
