// lib/widgets/contact_info_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teacher_provider.dart';

class ContactInfoCard extends StatefulWidget {
  const ContactInfoCard({Key? key}) : super(key: key);

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  bool _editing = false;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final teacher = Provider.of<TeacherProvider>(context, listen: false).teacher;
    _emailController = TextEditingController(text: teacher.email);
    _phoneController = TextEditingController(text: teacher.phoneNumber);
    _addressController = TextEditingController(text: teacher.address);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
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
          color: const Color(0xffcce1fe),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.contact_mail, color: Color(0xff0168fa)),
                const SizedBox(width: 8),
                Text(
                  'Información de Contacto',
                  style: TextStyle(
                    color: const Color(0xff163686),
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
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
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
                        // Validar campos
                        // Ejemplo simple:
                        if (_emailController.text.isEmpty ||
                            !_emailController.text.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ingrese un correo válido.'),
                            ),
                          );
                          return;
                        }
                        teacherProvider.updateContactInfo(
                          email: _emailController.text,
                          phoneNumber: _phoneController.text,
                          address: _addressController.text,
                        );
                        setState(() {
                          _editing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Datos de contacto actualizados'),
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
                _infoRow('Correo Electrónico:', teacher.email),
                _infoRow('Teléfono:', teacher.phoneNumber),
                _infoRow('Dirección:', teacher.address),
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
