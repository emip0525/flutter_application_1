// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Course App Smoke Test', (WidgetTester tester) async {
    // Memanggil MyApp sesuai dengan nama widget utama di main.dart Anda
    await tester.pumpWidget(const MyApp());

    // Memastikan widget MyApp berhasil dimuat
    expect(find.byType(MyApp), findsOneWidget);
  });
}