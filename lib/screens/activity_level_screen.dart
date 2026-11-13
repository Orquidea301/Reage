import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/screens/body_concern_screen.dart';

/// [ActivityLevelScreen] corresponde à etapa 02 do fluxo de onboarding do ReAge.
///
/// Tem como objetivo identificar a frequência e intensidade atual de exercícios
/// do utilizador idoso, apresentando cartões de seleção ampla com alto contraste
/// para facilitar a leitura e o toque.
class ActivityLevelScreen extends StatefulWidget {
  /// Nome do utilizador transportado desde o ecrã de registo inicial.
  final String userName;

  const ActivityLevelScreen({super.key, required this.userName});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  /// Armazena a opção atualmente selecionada pelo utilizador.
  /// Inicia com um valor padrão intermédio para evitar seleções vazias.
  String _selectedLevel =
      'Ocasionalmente faço exercícios ou caminho por 30 minutos';

  /// Lista de opções pré-definidas adaptadas à realidade e ritmo do público idoso.
  final List<String> _activityLevels = [
    'Quase nenhum exercício (Sedentário/a)',
    'Ocasionalmente faço exercícios ou caminho por 30 minutos',
    'Faço atividades leves regularmente',
    'Sou bastante ativo/a no dia a dia',
  ];

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
          '02 • AVALIAÇÃO FÍSICA',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal da pergunta com fonte ampliada para legibilidade
            const Text(
              'Qual é o seu nível de atividade física?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 24),

            // Lista interativa de cartões selecionáveis
            Expanded(
              child: ListView.builder(
                itemCount: _activityLevels.length,
                itemBuilder: (context, index) {
                  final level = _activityLevels[index];
                  final isSelected = _selectedLevel == level;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLevel = level;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          // Destaca visualmente o cartão selecionado com borda amarela
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryYellow
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Ícone de estado (selecionado vs não selecionado)
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected
                                  ? AppColors.primaryYellow
                                  : Colors.grey,
                              size: 28,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                level,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botão de ação principal para avançar no fluxo de cadastro
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
                onPressed: () {
                  // Navega para a próxima etapa (Focos Corporais) mantendo o nome do utilizador
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BodyConcernScreen(userName: widget.userName),
                    ),
                  );
                },
                child: const Text(
                  'PRÓXIMO',
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
}
