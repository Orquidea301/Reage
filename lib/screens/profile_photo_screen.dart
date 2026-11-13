import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_screen.dart';

/// [ProfilePhotoScreen] permite ao utilizador carregar uma fotografia de perfil
/// através da galeria do telemóvel ou prosseguir sem foto.
class ProfilePhotoScreen extends StatefulWidget {
  final String userName;
  final String userHeight;
  final String userWeight;
  final String userAge;

  const ProfilePhotoScreen({
    super.key,
    required this.userName,
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

  // Abre a galeria do dispositivo para selecionar a imagem de perfil
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível carregar a imagem.')),
      );
    }
  }

  // Simula um tempo de carregamento amigável e transita para o Lobby/Perfil principal
  void _saveAndProceed() async {
    setState(() {
      _isLoading = true;
    });

    // Simula tempo de configuração (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navega para o Perfil principal levando todos os dados recolhidos e a foto
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userName: widget.userName,
          userHeight: widget.userHeight,
          userWeight: widget.userWeight,
          userAge: widget.userAge,
          userPhoto: _selectedImage, // Passa a foto escolhida (ou null)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ecrã de carregamento exibido enquanto o perfil é configurado
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
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Estamos a configurar tudo para si.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
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
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha uma imagem ou continue sem foto.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Círculo interativo da foto com ícone da câmara
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
                    color: Colors.white,
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
