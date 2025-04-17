// lib/widgets/personal_info_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teacher_provider.dart';
import 'package:intl/intl.dart';

class PersonalInfoCard extends StatefulWidget {
  const PersonalInfoCard({Key? key}) : super(key: key);

  @override
  State<PersonalInfoCard> createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
  bool _editing = false;
  late TextEditingController _fullNameController;
  late TextEditingController _idController;
  late TextEditingController _nationalityController;
  late TextEditingController _genderController;
  DateTime _birthDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final teacher = Provider.of<TeacherProvider>(context, listen: false).teacher;
    _fullNameController = TextEditingController(text: teacher.fullName);
    _idController = TextEditingController(text: teacher.identificationNumber);
    _nationalityController = TextEditingController(text: teacher.nationality);
    _genderController = TextEditingController(text: teacher.gender);
    _birthDate = teacher.birthDate;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _idController.dispose();
    _nationalityController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);
    final teacher = teacherProvider.teacher;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffcce1fe), // azul/gris
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Color(0xff0168fa)), // azul boton
                const SizedBox(width: 8),
                Text(
                  'Datos Personales',
                  style: TextStyle(
                    color: const Color(0xff163686), // azul letras main
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(_editing ? Icons.cancel : Icons.edit),
                  color: const Color(0xff163686),
                  onPressed: () {
                    setState(() {
                      _editing = !_editing;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            _editing
                ? Column(
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nombre Completo'),
                ),
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Número de Cédula'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nationalityController,
                        decoration: const InputDecoration(labelText: 'Nacionalidad'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _genderController,
                        decoration: const InputDecoration(labelText: 'Género'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _pickDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
                    child: Text(DateFormat('dd/MM/yyyy').format(_birthDate)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0168fa), // azul boton
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        teacherProvider.updatePersonalInfo(
                          fullName: _fullNameController.text,
                          identificationNumber: _idController.text,
                          birthDate: _birthDate,
                          nationality: _nationalityController.text,
                          gender: _genderController.text,
                        );
                        setState(() {
                          _editing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Datos personales actualizados'),
                          ),
                        );
                      },
                      child: const Text('Guardar'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: const Color(0xff0168fa)),
                      ),
                      onPressed: () {
                        setState(() {
                          _editing = false;
                        });
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow('Nombre Completo:', teacher.fullName),
                _infoRow('N. De Cédula:', teacher.identificationNumber),
                _infoRow(
                  'Fecha de Nacimiento:',
                  DateFormat('dd/MM/yyyy').format(teacher.birthDate),
                ),
                _infoRow('Nacionalidad:', teacher.nationality),
                _infoRow('Género:', teacher.gender),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
