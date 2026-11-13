import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';

import 'profile_photo_screen.dart';

/// [WeightScreen] corresponde à etapa 04 do onboarding (Medidas Corporais).
/// Permite ao utilizador ajustar de forma interativa a sua idade, altura e peso
/// utilizando sliders de tamanho ampliado adequados para acessibilidade.
class WeightScreen extends StatefulWidget {
  final String userName; // Recebe o nome vindo das telas anteriores

  const WeightScreen({super.key, required this.userName});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  // Valores iniciais padrão configurados para o público idoso
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
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Deslize as barras para ajustar seus dados.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Cartão de Ajuste: Idade
            _buildSliderCard(
              title: 'Idade',
              valueText: '$_selectedAge anos',
              value: _selectedAge.toDouble(),
              min: 50,
              max: 100,
              divisions: 50,
              onChanged: (val) => setState(() => _selectedAge = val.round()),
            ),
            const SizedBox(height: 16),

            // Cartão de Ajuste: Altura
            _buildSliderCard(
              title: 'Altura',
              valueText: '${_selectedHeight.toStringAsFixed(2)} m',
              value: _selectedHeight,
              min: 1.30,
              max: 2.10,
              divisions: 80,
              onChanged: (val) => setState(() => _selectedHeight = val),
            ),
            const SizedBox(height: 16),

            // Cartão de Ajuste: Peso
            _buildSliderCard(
              title: 'Peso',
              valueText: '${_selectedWeight.toStringAsFixed(1)} kg',
              value: _selectedWeight,
              min: 35.0,
              max: 150.0,
              divisions: 230,
              onChanged: (val) => setState(() => _selectedWeight = val),
            ),
            const SizedBox(height: 32),

            // Botão para concluir a avaliação e avançar para a foto de perfil
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
                  // Empacota todos os dados recolhidos e envia para a tela seguinte
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePhotoScreen(
                        userName: widget.userName,
                        userHeight: '${_selectedHeight.toStringAsFixed(2)} m',
                        userWeight: '${_selectedWeight.toStringAsFixed(1)} kg',
                        userAge: '$_selectedAge anos',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'CONCLUIR AVALIAÇÃO',
                  style: TextStyle(
                    fontSize: 18,
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

  // Componente reutilizável para construir cartões com sliders personalizados
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
                ),
              ),
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryYellow,
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
