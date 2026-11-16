import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/screens/workout_screen.dart';

import '../services/app_state.dart';
import '../utils/format.dart';
import 'login_screen.dart';
import 'report_screen.dart';

/// [ProfileScreen] é o ecrã principal de perfil e hub de navegação do ReAge.
/// Gere a troca de abas (Treino, Relatório e Perfil) e exibe as informações
/// recolhidas do utilizador (nome, altura, peso, idade e contacto de emergência).
class ProfileScreen extends StatefulWidget {
  final String userName;
  final String userHeight;
  final String userWeight;
  final String userAge;
  final String emergencyContact;
  final dynamic userPhoto; // Mantido opcional para compatibilidade com outras telas

  const ProfileScreen({
    super.key,
    this.userName = 'nome',
    this.userHeight = '0000',
    this.userWeight = '0000',
    this.userAge = '0000',
    this.emergencyContact = '',
    this.userPhoto,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2; // Começa na aba Perfil por predefinição

  // Atualiza o índice da aba ativa na barra de navegação inferior
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: _buildBodyContent(),

      // Barra de navegação inferior acessível com itens grandes e claros
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryYellow,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatório',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  // Constrói o conteúdo dinâmico consoante a aba selecionada
  Widget _buildBodyContent() {
    if (_selectedIndex == 0) {
      return const WorkoutScreen();
    } else if (_selectedIndex == 1) {
      return ReportScreen(
        userWeight: widget.userWeight,
        userHeight: widget.userHeight,
        userAge: widget.userAge,
      );
    } else {
      // Aba de Perfil dinâmica com os dados reais do utilizador
      return Column(
        children: [
          // Cabeçalho Amarelo Superior com cantos arredondados e botão Sair temporário
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryYellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Círculo com o ícone padrão de pessoa
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              color: AppColors.white,
                            ),
                            child: const ClipOval(
                              child: Icon(
                                Icons.person,
                                size: 45,
                                color: AppColors.primaryYellow,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Nome dinâmico do utilizador em destaque
                          Text(
                            widget.userName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (widget.emergencyContact.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              'Contato de emergência: ${fmtPhone(widget.emergencyContact)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: SafeArea(
                    child: TextButton(
                      // TEMPORÁRIO: será substituído na etapa 6
                      onPressed: () {
                        AppState.instance.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Card Branco Central com as métricas corporais reais
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 28.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetricItem(widget.userHeight, 'Altura'),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  _buildMetricItem(widget.userWeight, 'Peso'),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  _buildMetricItem(widget.userAge, 'Idade'),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  // Constrói um item individual de métrica (valor e rótulo)
  Widget _buildMetricItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
