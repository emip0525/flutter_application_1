
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Course Explorer Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const CourseExplorerApp());
    expect(find.byType(CourseExplorerApp), findsOneWidget);
  });
}
