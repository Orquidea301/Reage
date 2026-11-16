import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_screen.dart';

// Permite carregar uma fotografia de perfil
// ou prosseguir sem foto.
class ProfilePhotoScreen extends StatefulWidget {
  final String userName;
  final String selectedGoal;
  final String activityLevel;
  final List<String> bodyConcerns;
  final String userHeight;
  final String userWeight;
  final String userAge;

  const ProfilePhotoScreen({
    super.key,
    required this.userName,
    required this.selectedGoal,
    required this.activityLevel,
    required this.bodyConcerns,
    required this.userHeight,
    required this.userWeight,
    required this.userAge,
  });

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _selectedImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Abre a galeria do dispositivo para selecionar a imagem
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível carregar a imagem.')),
      );
    }
  }

  // Salva e prossegue para o perfil principal
  Future<void> _saveAndProceed() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userName: widget.userName,
          userHeight: widget.userHeight,
          userWeight: widget.userWeight,
          userAge: widget.userAge,
          userPhoto: _selectedImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundCream,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: AppColors.primaryYellow,
                strokeWidth: 5,
              ),
              SizedBox(height: 24),
              Text(
                'A preparar o seu perfil...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Estamos a configurar tudo para si.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'FOTO DE PERFIL',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quer adicionar uma foto?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Times New Roman',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha uma imagem ou continue sem foto.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Times New Roman',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Círculo interativo da foto
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.primaryYellow,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person,
                                size: 80,
                                color: AppColors.primaryYellow,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryYellow,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Botão para avançar com ou sem foto
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _saveAndProceed,
                child: Text(
                  _selectedImage != null
                      ? 'AVANÇAR COM ESTA FOTO'
                      : 'CONTINUAR SEM FOTO',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
