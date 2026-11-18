import 'dart:io'; // Necessário para a classe File

import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/models/user_model.dart';
import 'package:idosos/screens/workout_screen.dart';

import 'report_screen.dart';

/// [ProfileScreen] é o ecrã principal de perfil e hub de navegação do ReAge.
/// Gere a troca de abas (Treino, Relatório e Perfil) e exibe/edita as informações
/// recolhidas do utilizador através do [UserModel].
class ProfileScreen extends StatefulWidget {
  final UserModel user;
  final File? userPhoto; // Foto de perfil vinda do onboarding

  const ProfileScreen({
    super.key,
    this.user = const UserModel(
      name: 'Visitante',
      height: '1.65 m',
      weight: '70.0 kg',
      age: '65 anos',
    ),
    this.userPhoto,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2; // Começa na aba Perfil por predefinição

  // Variáveis de estado para permitir edição interativa em tempo real
  late String _currentName;
  late String _currentHeight;
  late String _currentWeight;
  late String _currentAge;
  String _healthCondition = 'Mobilidade leve • Sem dores agudas';
  String _reminderTime = 'Todos os dias às 09:00';

  @override
  void initState() {
    super.initState();
    _currentName = widget.user.name;
    _currentHeight = widget.user.height;
    _currentWeight = widget.user.weight;
    _currentAge = widget.user.age;
  }

  // Atualiza o índice da aba ativa na barra de navegação inferior
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Diálogo interativo para editar Altura, Peso e Idade
  void _showEditMetricsDialog() {
    final heightController = TextEditingController(text: _currentHeight);
    final weightController = TextEditingController(text: _currentWeight);
    final ageController = TextEditingController(text: _currentAge);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Atualizar Medidas',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(heightController, 'Altura (ex: 1.65 m)'),
            const SizedBox(height: 12),
            _buildDialogTextField(weightController, 'Peso (ex: 70.0 kg)'),
            const SizedBox(height: 12),
            _buildDialogTextField(ageController, 'Idade (ex: 65 anos)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                _currentHeight = heightController.text;
                _currentWeight = weightController.text;
                _currentAge = ageController.text;
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryYellow),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryYellow),
        ),
      ),
    );
  }

  // Diálogo interativo para atualizar condições de saúde/restrições
  void _showEditHealthDialog() {
    final healthController = TextEditingController(text: _healthCondition);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Estado de Saúde e Mobilidade',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        content: _buildDialogTextField(
          healthController,
          'Ex: Dor no joelho direito, hipertensão...',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                _healthCondition = healthController.text;
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ],
      ),
    );
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
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Times New Roman',
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Times New Roman'),
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
      // Passa os valores atualizados dinamicamente via UserModel para o Relatório
      return ReportScreen(
        user: UserModel(
          name: _currentName,
          height: _currentHeight,
          weight: _currentWeight,
          age: _currentAge,
        ),
      );
    } else {
      // Aba de Perfil dinâmica e interativa com scroll para evitar overflow
      return SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho Amarelo Superior com cantos arredondados
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 28, top: 16),
              decoration: const BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Círculo com a fotografia personalizada do utilizador (ou ícone padrão)
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        color: AppColors.white,
                      ),
                      child: ClipOval(
                        child: widget.userPhoto != null
                            ? Image.file(
                                widget.userPhoto!,
                                width: 75,
                                height: 75,
                                fit: BoxFit.cover,
                              )
                            : const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.person,
                                  size: 48,
                                  color: AppColors.primaryYellow,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Nome dinâmico do utilizador em destaque (preto para alto contraste)
                    Text(
                      _currentName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Membro ReAge Seguro',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Card Branco Central Interativo com as métricas corporais reais
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: _showEditMetricsDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 22.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMetricItem(_currentHeight, 'Altura'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          _buildMetricItem(_currentWeight, 'Peso'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          _buildMetricItem(_currentAge, 'Idade'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Toque para atualizar suas medidas',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Secção Detalhada e Interativa do Perfil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detalhes e Cuidados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cartão 1: Estado de Saúde (Editável pelo idoso)
                  _buildDetailCard(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Condição Física e Restrições',
                    subtitle: _healthCondition,
                    onTap: _showEditHealthDialog,
                  ),
                  const SizedBox(height: 12),

                  // Cartão 2: Lembretes de Treino (Interativo)
                  _buildDetailCard(
                    icon: Icons.notifications_active_outlined,
                    title: 'Lembrete Diário de Exercícios',
                    subtitle: _reminderTime,
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 9, minute: 0),
                      );
                      if (picked != null) {
                        setState(() {
                          _reminderTime =
                              'Todos os dias às ${picked.format(context)}';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Cartão 3: Resumo de Objetivo
                  _buildDetailCard(
                    icon: Icons.emoji_events_outlined,
                    title: 'Foco do Plano Atual',
                    subtitle: 'Equilíbrio, Força e Bem-estar',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Seu plano está adaptado para exercícios seguros em casa.',
                            style: TextStyle(fontFamily: 'Times New Roman'),
                          ),
                          backgroundColor: Colors.black87,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
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
            fontFamily: 'Times New Roman',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontFamily: 'Times New Roman',
          ),
        ),
      ],
    );
  }

  // Constrói os cartões de detalhes interativos abaixo das medidas
  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryYellow.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black87, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            fontFamily: 'Times New Roman',
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontFamily: 'Times New Roman',
            ),
          ),
        ),
        trailing: const Icon(
          Icons.edit_outlined,
          size: 20,
          color: AppColors.primaryYellow,
        ),
        onTap: onTap,
      ),
    );
  }
}
