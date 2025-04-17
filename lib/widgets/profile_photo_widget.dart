// lib/widgets/profile_photo_widget.dart

import 'dart:io'; // Necesario para usar File
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/teacher_provider.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProvider>(context);
    final photoUrl = teacherProvider.teacher.photoUrl;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: photoUrl.isNotEmpty
              ? (File(photoUrl).existsSync()
              ? FileImage(File(photoUrl))
              : const AssetImage('assets/images/default_profile.png') as ImageProvider)
              : const AssetImage('assets/images/default_profile.png') as ImageProvider,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                await teacherProvider.updateProfilePhoto(ImageSource.camera);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Foto actualizada desde la cámara'),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () async {
                await teacherProvider.updateProfilePhoto(ImageSource.gallery);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Foto actualizada desde la galería'),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
