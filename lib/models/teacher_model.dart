// lib/models/teacher_model.dart

class TeacherModel {
  String fullName;
  String identificationNumber;
  DateTime birthDate;
  String nationality;
  String gender;
  String photoUrl;
  String email;
  String phoneNumber;
  String address;

  TeacherModel({
    required this.fullName,
    required this.identificationNumber,
    required this.birthDate,
    required this.nationality,
    required this.gender,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

// Puedes incluir funciones de serialización si conectas con servicios web
}
