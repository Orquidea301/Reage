import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/screens/body_concern_screen.dart';

class ActivityLevelScreen extends StatefulWidget {
  final String userName;
  final String selectedGoal;

  const ActivityLevelScreen({
    super.key,
    required this.userName,
    required this.selectedGoal,
  });

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  String _selectedLevel =
      'Ocasionalmente faço exercícios ou caminho por 30 minutos';

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
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Qual é o seu nível de atividade física?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Times New Roman',
              ),
            ),
            const SizedBox(height: 24),
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
                                  fontFamily: 'Times New Roman',
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
                  // Envia o utilizador para a próxima tela.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BodyConcernScreen(
                        userName: widget.userName,
                        selectedGoal: widget.selectedGoal,
                        activityLevel: _selectedLevel,
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
}
