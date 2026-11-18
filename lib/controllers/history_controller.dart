import '../models/plan_activity.dart';
import '../services/plan_service.dart';

/// [HistoryController] gerencia o estado e a lógica de negócios da tela de histórico (plano pessoal).
class HistoryController {
  // Dia selecionado atualmente (começa em 1)
  int selectedDay = 1;

  // Mapa com o plano de atividades por dia, inicializado através do PlanService
  final Map<int, List<PlanActivity>> planActivities =
      PlanService.buildInitialPlan();

  /// Seleciona um novo dia no plano.
  void selectDay(int day) {
    selectedDay = day;
  }

  /// Retorna as atividades do dia selecionado ou as atividades padrão se não houver plano para o dia.
  List<PlanActivity> get activitiesForSelectedDay {
    return planActivities[selectedDay] ?? PlanService.buildDefaultActivities();
  }

  /// Atualiza o estado de conclusão (done) de uma atividade específica.
  void setDone(PlanActivity activity, bool? value) {
    activity.done = value ?? false;
  }
}
