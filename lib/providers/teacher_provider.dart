// lib/providers/teacher_provider.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/teacher_model.dart';

class TeacherProvider with ChangeNotifier {
  TeacherModel _teacher = TeacherModel(
    fullName: 'Juan Augusto Acosta Pereira',
    identificationNumber: '5045679',
    birthDate: DateTime(2001, 7, 4),
    nationality: 'Paraguay',
    gender: 'Masculino',
    photoUrl: '', // O alguna URL inicial
    email: 'juanacostapereira@gmail.com',
    phoneNumber: '0982 626298',
    address: 'Sin datos',
  );

  TeacherModel get teacher => _teacher;

  // Para edición, podrías guardar en variables temporales
  // o utilizar el mismo modelo y luego confirmarlo.

  // Actualizar datos personales
  void updatePersonalInfo({
    required String fullName,
    required String identificationNumber,
    required DateTime birthDate,
    required String nationality,
    required String gender,
  }) {
    _teacher = TeacherModel(
      fullName: fullName,
      identificationNumber: identificationNumber,
      birthDate: birthDate,
      nationality: nationality,
      gender: gender,
      photoUrl: _teacher.photoUrl,
      email: _teacher.email,
      phoneNumber: _teacher.phoneNumber,
      address: _teacher.address,
    );
    notifyListeners();
  }

  // Actualizar información de contacto
  void updateContactInfo({
    required String email,
    required String phoneNumber,
    required String address,
  }) {
    _teacher = TeacherModel(
      fullName: _teacher.fullName,
      identificationNumber: _teacher.identificationNumber,
      birthDate: _teacher.birthDate,
      nationality: _teacher.nationality,
      gender: _teacher.gender,
      photoUrl: _teacher.photoUrl,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
    );
    notifyListeners();
  }

  // Actualizar foto de perfil
  Future<void> updateProfilePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Si usas un servicio en la nube, podrías subir la foto
      // y obtener su URL. Por ahora, se usará la ruta local:
      _teacher = TeacherModel(
        fullName: _teacher.fullName,
        identificationNumber: _teacher.identificationNumber,
        birthDate: _teacher.birthDate,
        nationality: _teacher.nationality,
        gender: _teacher.gender,
        photoUrl: pickedFile.path,
        email: _teacher.email,
        phoneNumber: _teacher.phoneNumber,
        address: _teacher.address,
      );
      notifyListeners();
    }
  }
}
