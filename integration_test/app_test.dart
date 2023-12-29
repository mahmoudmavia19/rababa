import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rababa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Screen test ', () {
    testWidgets('test splash screen is work',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();
           await tester.pumpAndSettle();
          final Finder fab = find.text('Music for All') ;
          expect(fab, findsOneWidget) ;
         });
  });
}