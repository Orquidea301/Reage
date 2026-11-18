import 'package:flutter/material.dart';
import 'package:idosos/src/constants/colors.dart';
import 'package:idosos/src/models/user_model.dart';

import 'profile_screen.dart';
import 'report_screen.dart';
import 'workout_screen.dart';

/// [DashboardScreen] é o ecrã principal (Lobby) do ReAge após o onboarding.
/// Gere a navegação inferior entre as abas de Treino, Relatório e Perfil.
class DashboardScreen extends StatefulWidget {
  final UserModel user;
  final dynamic userPhoto;

  const DashboardScreen({
    super.key,
    required this.user,
    this.userPhoto,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Índice da aba atualmente selecionada na barra inferior
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Lista de ecrãs acessíveis através da barra de navegação inferior
    final List<Widget> screens = [
      // Aba 0: Ecrã de Treinos e Atividades Diárias
      const WorkoutScreen(),

      // Aba 1: Relatório de Progresso e Métricas baseado no UserModel
      ReportScreen(
        user: widget.user,
      ),

      // Aba 2: Perfil Completo do Utilizador
      ProfileScreen(
        user: widget.user,
        userPhoto: widget.userPhoto,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,

      // Exibe o ecrã correspondente à aba selecionada
      body: screens[_currentIndex],

      // Barra de navegação inferior adaptada para idosos (itens grandes e claros)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryYellow,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, size: 28),
            label: 'Treino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, size: 28),
            label: 'Relatório',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
