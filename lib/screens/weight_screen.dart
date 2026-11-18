import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/models/user_model.dart';

import 'profile_photo_screen.dart';

// WeightScreen corresponde à etapa 04 do onboarding (Medidas Corporais).
// Permite ajustar idade, altura e peso utilizando sliders.
class WeightScreen extends StatefulWidget {
  final String userName;
  final String selectedGoal;
  final String activityLevel;
  final List<String> bodyConcerns;

  const WeightScreen({
    super.key,
    required this.userName,
    required this.selectedGoal,
    required this.activityLevel,
    required this.bodyConcerns,
  });

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  // Valores iniciais padrão
  double _selectedWeight = 70.0;
  double _selectedHeight = 1.65;
  int _selectedAge = 65;

  @override
  Widget build(BuildContext context) {
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
          '04 • SUAS MEDIDAS',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Conte-nos um pouco sobre você',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Times New Roman',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              'Deslize as barras para ajustar seus dados.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Times New Roman',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Cartão de ajuste: Idade
            _buildSliderCard(
              title: 'Idade',
              valueText: '$_selectedAge anos',
              value: _selectedAge.toDouble(),
              min: 50,
              max: 100,
              divisions: 50,
              onChanged: (val) {
                setState(() {
                  _selectedAge = val.round();
                });
              },
            ),

            const SizedBox(height: 16),

            // Cartão de ajuste: Altura
            _buildSliderCard(
              title: 'Altura',
              valueText: '${_selectedHeight.toStringAsFixed(2)} m',
              value: _selectedHeight,
              min: 1.30,
              max: 2.10,
              divisions: 80,
              onChanged: (val) {
                setState(() {
                  _selectedHeight = val;
                });
              },
            ),

            const SizedBox(height: 16),

            // Cartão de ajuste: Peso
            _buildSliderCard(
              title: 'Peso',
              valueText: '${_selectedWeight.toStringAsFixed(1)} kg',
              value: _selectedWeight,
              min: 35.0,
              max: 150.0,
              divisions: 230,
              onChanged: (val) {
                setState(() {
                  _selectedWeight = val;
                });
              },
            ),

            const SizedBox(height: 32),

            // Botão para avançar para a foto de perfil
            SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePhotoScreen(
                        user: UserModel(
                          name: widget.userName,
                          height: '${_selectedHeight.toStringAsFixed(2)} m',
                          weight: '${_selectedWeight.toStringAsFixed(1)} kg',
                          age: '$_selectedAge anos',
                        ),
                        selectedGoal: widget.selectedGoal,
                        activityLevel: widget.activityLevel,
                        bodyConcerns: widget.bodyConcerns,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'PRÓXIMO',
                  style: TextStyle(
                    fontSize: 18,
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

  // Componente reutilizável para construir os cartões com sliders
  Widget _buildSliderCard({
    required String title,
    required String valueText,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryYellow,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ],
          ),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primaryYellow,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: AppColors.primaryYellow,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14.0),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
