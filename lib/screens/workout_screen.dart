import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';

/// [WorkoutScreen] é o ecrã responsável por exibir os treinos em casa,
/// rotinas de aquecimento e exercícios recomendados adaptados para idosos.
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho da Tela de Treino com indicador de segurança
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TREINO EM CASA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.primaryYellow,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'ReAge SEGURO',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryYellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Seção: Alongar e Aquecer (rolagem horizontal)
              const Text(
                'Alongar e Aquecer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildWarmupCard(
                      'Mobilidade de Ombros',
                      '5 min • Suave',
                      Icons.accessibility_new,
                    ),
                    const SizedBox(width: 12),
                    _buildWarmupCard(
                      'Alongamento de Pernas',
                      '7 min • Sentado',
                      Icons.self_improvement,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seção: Séries Personalizadas para o perfil do utilizador
              const Text(
                'Recomendado para o seu perfil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Cartões de Exercícios Adaptados (Baixo impacto e segurança)
              _buildExerciseCard(
                context,
                title: 'Fortalecimento de Quadríceps',
                duration: '12 min • Baixo Impacto',
                level: 'Iniciante',
                icon: Icons.fitness_center,
              ),
              const SizedBox(height: 12),
              _buildExerciseCard(
                context,
                title: 'Equilíbrio e Estabilidade',
                duration: '10 min • Com Apoio',
                level: 'Essencial',
                icon: Icons.balance,
              ),
              const SizedBox(height: 12),
              _buildExerciseCard(
                context,
                title: 'Respiração e Postura',
                duration: '8 min • Relaxamento',
                level: 'Suave',
                icon: Icons.spa,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para construir cartões horizontais de aquecimento
  Widget _buildWarmupCard(String title, String subtitle, IconData icon) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppColors.primaryYellow),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir cartões verticais de exercícios
  Widget _buildExerciseCard(
    BuildContext context, {
    required String title,
    required String duration,
    required String level,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryYellow.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: AppColors.primaryYellow),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$duration • $level',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
