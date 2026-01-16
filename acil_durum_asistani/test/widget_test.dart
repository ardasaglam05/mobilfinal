// Test dosyası - Acil Durum Asistanı
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acil_durum_asistani/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AcilDurumAsistaniApp());

    // Verify that home screen loads
    expect(find.text('Acil Durum Asistanı'), findsOneWidget);
    expect(find.text('DEPREM'), findsOneWidget);
    expect(find.text('GÜVENDEYİM'), findsOneWidget);
    expect(find.text('YAKINLAR'), findsOneWidget);
  });
}
