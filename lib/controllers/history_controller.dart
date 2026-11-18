import 'package:flutter/foundation.dart';
import '../models/plan_activity.dart';
import '../services/plan_service.dart';

/// [HistoryController] gerencia o estado reativo e a lógica de negócios da tela de histórico (plano pessoal).
class HistoryController extends ChangeNotifier {
  // Dia selecionado atualmente (começa em 1)
  int selectedDay = 1;

  // Mapa com o plano de atividades por dia, inicializado através do PlanService
  final Map<int, List<PlanActivity>> planActivities =
      PlanService.buildInitialPlan();

  /// Seleciona um novo dia no plano e notifica os ouvintes.
  void selectDay(int day) {
    selectedDay = day;
    notifyListeners();
  }

  /// Retorna as atividades do dia selecionado ou as atividades padrão se não houver plano para o dia.
  List<PlanActivity> get activitiesForSelectedDay {
    return planActivities[selectedDay] ?? PlanService.buildDefaultActivities();
  }

  /// Atualiza o estado de conclusão (done) de uma atividade específica e notifica os ouvintes.
  void setDone(PlanActivity activity, bool? value) {
    activity.done = value ?? false;
    notifyListeners();
  }
}
