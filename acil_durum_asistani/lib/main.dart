import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AcilDurumAsistaniApp());
}

class AcilDurumAsistaniApp extends StatelessWidget {
  const AcilDurumAsistaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acil Durum Asistanı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
