import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:farm_wise_ai/main.dart';

void main() {
  testWidgets('app boots', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: FarmWiseAiApp(),
      ),
    );

    expect(find.byType(FarmWiseAiApp), findsOneWidget);
  });
}
