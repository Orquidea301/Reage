import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/workout_category.dart';

/// [WorkoutService] fornece os dados estáticos de categorias e exercícios de treino.
class WorkoutService {
  /// Lista de categorias de aquecimento.
  static const List<WorkoutCategory> warmupCategories = [
    WorkoutCategory(
      title: 'Mobilidade de Ombros',
      subtitle: '5 min • Suave',
      icon: Icons.accessibility_new,
      exercises: [
        Exercise(
          title: 'Mobilidade suave dos ombros',
          subtitle: '2 min • Leve • Mobilidade',
          description: 'Sentado, realize movimentos circulares lentos com os ombros para trás.',
          image: 'assets/images/ex3.png',
        ),
        Exercise(
          title: 'Alongamento de braços',
          subtitle: '3 min • Leve • Alongamento',
          description: 'Estique o braço à frente e puxe levemente.',
          image: 'assets/images/ex4.png',
        ),
      ],
    ),
    WorkoutCategory(
      title: 'Alongamento de Pernas',
      subtitle: '7 min • Sentado',
      icon: Icons.self_improvement,
      exercises: [
        Exercise(
          title: 'Extensão de pernas sentado',
          subtitle: '4 min • Leve • Pernas',
          description: 'Estique a perna à frente de forma controlada.',
          image: 'assets/images/ex1.png',
        ),
        Exercise(
          title: 'Movimentação dos tornozelos',
          subtitle: '3 min • Leve • Mobilidade',
          description: 'Rode os pés lentamente para ambos os lados.',
          image: 'assets/images/ex2.png',
        ),
      ],
    ),
  ];

  /// Lista de categorias recomendadas para o perfil.
  static const List<WorkoutCategory> recommendedCategories = [
    WorkoutCategory(
      title: 'Fortalecimento de Quadríceps',
      subtitle: '12 min • Baixo Impacto',
      level: 'Iniciante',
      icon: Icons.fitness_center,
      exercises: [
        Exercise(
          title: 'Elevação de perna sentada',
          subtitle: '6 min • Iniciante • Força',
          description: 'Sentado na cadeira, levante a perna mantendo-a reta por 5 segundos.',
          image: 'assets/images/ex1.png',
        ),
        Exercise(
          title: 'Flexão leve de joelhos',
          subtitle: '6 min • Iniciante • Estabilidade',
          description: 'Com apoio na parede, flexione levemente os joelhos sem forçar.',
          image: 'assets/images/ex4.png',
        ),
      ],
    ),
    WorkoutCategory(
      title: 'Equilíbrio e Estabilidade',
      subtitle: '10 min • Com Apoio',
      level: 'Essencial',
      icon: Icons.balance,
      exercises: [
        Exercise(
          title: 'Apoio unipodal com suporte',
          subtitle: '5 min • Com Apoio • Equilíbrio',
          description: 'Segurando firme na cadeira, levante um pé do chão por 5 segundos.',
          image: 'assets/images/ex2.png',
        ),
        Exercise(
          title: 'Caminhada calcanhar-ponta',
          subtitle: '5 min • Essencial • Postura',
          description: 'Dê passos curtos alinhando o calcanhar com a ponta do pé.',
          image: 'assets/images/ex3.png',
        ),
      ],
    ),
    WorkoutCategory(
      title: 'Respiração e Postura',
      subtitle: '8 min • Relaxamento',
      level: 'Suave',
      icon: Icons.spa,
      exercises: [
        Exercise(
          title: 'Respiração e relaxamento sentado',
          subtitle: '4 min • Leve • Relaxamento',
          description: 'Inspire profundamente pelo nariz e expire devagar pela boca.',
          image: 'assets/images/ex5.png',
        ),
        Exercise(
          title: 'Alinhamento postural',
          subtitle: '4 min • Suave • Postura',
          description: 'Endireite a coluna e alinhe os ombros respirando calmamente.',
          image: 'assets/images/ex5.png',
        ),
      ],
    ),
  ];
}
