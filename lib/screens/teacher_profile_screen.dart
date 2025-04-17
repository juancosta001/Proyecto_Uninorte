// lib/screens/teacher_profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teacher_provider.dart';
import '../widgets/personal_info_card.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/profile_photo_widget.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff042893), // azul header
        title: Text(
          'Perfil del Docente',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff052fac), // azul costado
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                CircleAvatar(
                radius: 40,
                backgroundImage: teacherProvider.teacher.photoUrl.isNotEmpty
                    ? (File(teacherProvider.teacher.photoUrl).existsSync()
                    ? FileImage(File(teacherProvider.teacher.photoUrl))
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider)
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                ),
                  const SizedBox(height: 8),
                  Text(
                    teacherProvider.teacher.fullName,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Inicio', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Acción al pulsar
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Configuraciones', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ejemplo: cambiar contraseña, preferencias
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              // Foto de perfil
              ProfilePhotoWidget(),
              SizedBox(height: 16),
              // Datos personales
              PersonalInfoCard(),
              SizedBox(height: 16),
              // Datos de contacto
              ContactInfoCard(),
              SizedBox(height: 16),
              // Aquí podrías añadir más secciones, como cursos impartidos, calendario, etc.
            ],
          ),
        ),
      ),
    );
  }
}
