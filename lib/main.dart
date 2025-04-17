// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/teacher_provider.dart';
import 'screens/teacher_profile_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TeacherProvider>(create: (_) => TeacherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Colores globales (opcionales)
  static const Color azulGris = Color(0xffcce1fe);
  static const Color azulCostado = Color(0xff052fac);
  static const Color azulHeader = Color(0xff042893);
  static const Color amarillo = Color(0xffffc107);
  static const Color azulBoton = Color(0xff0168fa);
  static const Color azulLetrasCostado = Color(0xff3061d1);
  static const Color azulLetrasMain = Color(0xff163686);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Docente',
      theme: ThemeData(
        primaryColor: azulHeader,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const TeacherProfileScreen(),
    );
  }
}
