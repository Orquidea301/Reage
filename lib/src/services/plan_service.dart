import '../models/plan_activity.dart';

/// [PlanService] fornece os dados iniciais e padrões para o plano de 28 dias.
class PlanService {
  /// Retorna um novo mapa com as atividades iniciais do plano (dias 1, 2 e 3).
  static Map<int, List<PlanActivity>> buildInitialPlan() {
    return {
      1: [
        PlanActivity(
          title: 'Respiração e relaxamento sentado',
          subtitle: '2 min • Leve • Relaxamento',
          done: true,
        ),
        PlanActivity(
          title: 'Mobilidade suave dos ombros',
          subtitle: '2 min • Leve • Mobilidade',
          done: true,
        ),
        PlanActivity(
          title: 'Movimentação dos tornozelos',
          subtitle: '2 min • Leve • Mobilidade',
          done: false,
        ),
      ],
      2: [
        PlanActivity(
          title: 'Alongamento suave dos braços',
          subtitle: '2 min • Leve • Alongamento',
          done: false,
        ),
        PlanActivity(
          title: 'Movimentação das mãos e dedos',
          subtitle: '2 min • Leve • Coordenação',
          done: false,
        ),
      ],
      3: [
        PlanActivity(
          title: 'Fortalecimento leve de pernas',
          subtitle: '3 min • Iniciante • Força',
          done: false,
        ),
        PlanActivity(
          title: 'Equilíbrio com apoio',
          subtitle: '3 min • Essencial • Postura',
          done: false,
        ),
      ],
    };
  }

  /// Retorna uma nova lista de atividades padrão para dias sem plano cadastrado.
  static List<PlanActivity> buildDefaultActivities() {
    return [
      PlanActivity(
        title: 'Atividades de mobilidade geral',
        subtitle: '5 min • Suave',
        done: false,
      ),
    ];
  }
}
