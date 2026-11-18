// Tela 4 (Menu superior e navegação)
import 'package:flutter/material.dart';
import 'package:idosos/src/constants/colors.dart';

import 'login_screen.dart';
import 'onboarding_screen.dart'; // Importa o ecrã de onboarding/perguntas

/// [MenuScreen] apresenta as opções adicionais, configurações de acessibilidade
/// e saída da conta no aplicativo ReAge.
class MenuScreen extends StatefulWidget {
  final String userName;

  const MenuScreen({super.key, required this.userName});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Estados de preferências de acessibilidade do utilizador
  bool _notificationsEnabled = true;
  bool _largeFontEnabled = true;

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
          'OPÇÕES E AJUDA',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Cartão com identificação rápida do utilizador
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryYellow,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
          const Text(
            'Acessibilidade e Lembretes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          // Interruptor para lembretes diários de exercícios e água
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: 'Lembretes Diários',
            subtitle: 'Avisos para beber água e fazer alongamentos',
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),

          const SizedBox(height: 12),

          // Interruptor para ajuste de tamanho de letra
          _buildSwitchTile(
            icon: Icons.text_fields,
            title: 'Letras Ampliadas',
            subtitle: 'Mantém os textos maiores para leitura confortável',
            value: _largeFontEnabled,
            onChanged: (val) => setState(() => _largeFontEnabled = val),
          ),

          const SizedBox(height: 28),
          const Text(
            'Suporte e Avaliação',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          // NOVO BOTÃO: Chamar o Onboarding / Perguntas a partir do menu
          _buildActionTile(
            icon: Icons.assignment_outlined,
            title: 'Refazer Avaliação Física',
            subtitle: 'Atualize suas metas, nível e dados corporais',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Botão de Ajuda / Contato de Emergência
          _buildActionTile(
            icon: Icons.help_outline,
            title: 'Preciso de Ajuda',
            subtitle: 'Instruções simples de como usar o ReAge',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Toque em "Treino" na barra inferior para iniciar os exercícios.',
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          // Botão de Sair da Conta
          SizedBox(
            width: double.infinity,
            height: 55,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                // Retorna para o ecrã de Login limpando o histórico de navegação
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                'SAIR DA CONTA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Constrói um cartão com interruptor (Switch) de fácil toque
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        activeColor: AppColors.primaryYellow,
        secondary: Icon(icon, color: AppColors.primaryYellow, size: 28),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // Constrói um cartão clicável de ação
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primaryYellow, size: 28),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
