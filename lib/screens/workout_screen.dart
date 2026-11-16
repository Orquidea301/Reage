import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';

// [WorkoutScreen] exibe o ecrã principal de treinos com categorias organizadas
// (Aquecimento e Séries recomendadas para o perfil) que abrem listas detalhadas ao tocar.
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
              // Cabeçalho da Tela de Treino
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TREINO EM CASA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFf6ba02).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFf6ba02), size: 18),
                        SizedBox(width: 4),
                        Text(
                          'ReAge SEGURO',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFf6ba02),
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Seção: Alongar e Aquecer
              const Text(
                'Alongar e Aquecer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildWarmupCard(
                      context,
                      title: 'Mobilidade de Ombros',
                      subtitle: '5 min • Suave',
                      icon: Icons.accessibility_new,
                      exercises: [
                        {
                          'title': 'Mobilidade suave dos ombros',
                          'subtitle': '2 min • Leve • Mobilidade',
                          'description': 'Sentado, realize movimentos circulares lentos com os ombros para trás.',
                          'image': 'assets/images/ex3.png',
                        },
                        {
                          'title': 'Alongamento de braços',
                          'subtitle': '3 min • Leve • Alongamento',
                          'description':
                              'Estique o braço à frente e puxe levemente.',
                          'image': 'assets/images/ex4.png',
                        },
                      ],
                    ),
                    const SizedBox(width: 12),
                    _buildWarmupCard(
                      context,
                      title: 'Alongamento de Pernas',
                      subtitle: '7 min • Sentado',
                      icon: Icons.self_improvement,
                      exercises: [
                        {
                          'title': 'Extensão de pernas sentado',
                          'subtitle': '4 min • Leve • Pernas',
                          'description':
                              'Estique a perna à frente de forma controlada.',
                          'image': 'assets/images/ex1.png',
                        },
                        {
                          'title': 'Movimentação dos tornozelos',
                          'subtitle': '3 min • Leve • Mobilidade',
                          'description':
                              'Rode os pés lentamente para ambos os lados.',
                          'image': 'assets/images/ex2.png',
                        },
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seção: Recomendado para o seu perfil
              const Text(
                'Recomendado para o seu perfil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 12),

              // Cartão 1: Fortalecimento de Quadríceps
              _buildExerciseCategoryCard(
                context,
                title: 'Fortalecimento de Quadríceps',
                duration: '12 min • Baixo Impacto',
                level: 'Iniciante',
                icon: Icons.fitness_center,
                exercises: [
                  {
                    'title': 'Elevação de perna sentada',
                    'subtitle': '6 min • Iniciante • Força',
                    'description': 'Sentado na cadeira, levante a perna mantendo-a reta por 5 segundos.',
                    'image': 'assets/images/ex1.png',
                  },
                  {
                    'title': 'Flexão leve de joelhos',
                    'subtitle': '6 min • Iniciante • Estabilidade',
                    'description': 'Com apoio na parede, flexione levemente os joelhos sem forçar.',
                    'image': 'assets/images/ex4.png',
                  },
                ],
              ),
              const SizedBox(height: 12),

              // Cartão 2: Equilíbrio e Estabilidade
              _buildExerciseCategoryCard(
                context,
                title: 'Equilíbrio e Estabilidade',
                duration: '10 min • Com Apoio',
                level: 'Essencial',
                icon: Icons.balance,
                exercises: [
                  {
                    'title': 'Apoio unipodal com suporte',
                    'subtitle': '5 min • Com Apoio • Equilíbrio',
                    'description': 'Segurando firme na cadeira, levante um pé do chão por 5 segundos.',
                    'image': 'assets/images/ex2.png',
                  },
                  {
                    'title': 'Caminhada calcanhar-ponta',
                    'subtitle': '5 min • Essencial • Postura',
                    'description': 'Dê passos curtos alinhando o calcanhar com a ponta do pé.',
                    'image': 'assets/images/ex3.png',
                  },
                ],
              ),
              const SizedBox(height: 12),

              // Cartão 3: Respiração e Postura
              _buildExerciseCategoryCard(
                context,
                title: 'Respiração e Postura',
                duration: '8 min • Relaxamento',
                level: 'Suave',
                icon: Icons.spa,
                exercises: [
                  {
                    'title': 'Respiração e relaxamento sentado',
                    'subtitle': '4 min • Leve • Relaxamento',
                    'description': 'Inspire profundamente pelo nariz e expire devagar pela boca.',
                    'image': 'assets/images/ex5.png',
                  },
                  {
                    'title': 'Alinhamento postural',
                    'subtitle': '4 min • Suave • Postura',
                    'description': 'Endireite a coluna e alinhe os ombros respirando calmamente.',
                    'image': 'assets/images/ex5.png',
                  },
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cartão horizontal de Aquecimento
  Widget _buildWarmupCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Map<String, String>> exercises,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryWorkoutScreen(
              categoryTitle: title,
              exercises: exercises,
            ),
          ),
        );
      },
      child: Container(
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
            Icon(icon, size: 32, color: const Color(0xFFf6ba02)),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Times New Roman',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cartão vertical de Categoria Recomendada
  Widget _buildExerciseCategoryCard(
    BuildContext context, {
    required String title,
    required String duration,
    required String level,
    required IconData icon,
    required List<Map<String, String>> exercises,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryWorkoutScreen(
              categoryTitle: title,
              exercises: exercises,
            ),
          ),
        );
      },
      child: Container(
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
                color: const Color(0xFFf6ba02).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: const Color(0xFFf6ba02)),
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
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$duration • $level',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// Ecrã de Listagem Detalhada da Categoria
class CategoryWorkoutScreen extends StatefulWidget {
  final String categoryTitle;
  final List<Map<String, String>> exercises;

  const CategoryWorkoutScreen({
    super.key,
    required this.categoryTitle,
    required this.exercises,
  });

  @override
  State<CategoryWorkoutScreen> createState() => _CategoryWorkoutScreenState();
}

class _CategoryWorkoutScreenState extends State<CategoryWorkoutScreen> {
  late List<bool> _completedStatus;

  @override
  void initState() {
    super.initState();

    _completedStatus = List.generate(widget.exercises.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: const Color(0xFFf6ba02),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = widget.exercises[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {
                        _showExerciseDetailDialog(context, exercise);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFf6ba02)
                                    .withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.star,
                                color: Color(0xFFf6ba02),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise['title']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                      fontFamily: 'Times New Roman',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exercise['subtitle']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      fontFamily: 'Times New Roman',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Botão para marcar exercício como feito
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _completedStatus[index] =
                                      !_completedStatus[index];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFf6ba02),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: _completedStatus[index]
                                      ? const Color(0xFFf6ba02).withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _completedStatus[index]
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      size: 16,
                                      color: AppColors.textDark,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Feito',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Times New Roman',
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }

  // Janela pop-up de detalhes do exercício
  void _showExerciseDetailDialog(
    BuildContext context,
    Map<String, String> exercise,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '✕ Fechar',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  exercise['title']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  exercise['description']!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const SizedBox(height: 20),

                // Imagem do exercício
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFf8f0de),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFf6ba02).withOpacity(0.5),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      exercise['image'] ?? 'assets/images/logo_reage.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf6ba02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Entendi',
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
        ),
      ),
    );
  }
}
