import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Learning Dashboard Smoke Test', (WidgetTester tester) async {
    // Memuat aplikasi utama
    await tester.pumpWidget(const LearningDashboardApp());

    // Verifikasi bahwa aplikasi berhasil dirender
    expect(find.byType(LearningDashboardApp), findsOneWidget);
  });
}