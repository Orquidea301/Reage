import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

/// [ProfileController] gerencia o estado reativo e a lógica de edição do perfil do utilizador.
class ProfileController extends ChangeNotifier {
  UserModel user;
  String healthCondition = 'Mobilidade leve • Sem dores agudas';
  String reminderTime = 'Todos os dias às 09:00';

  ProfileController({
    required this.user,
  });

  /// Atualiza as métricas corporais (altura, peso, idade) usando copyWith e notifica os ouvintes.
  void updateMetrics({
    required String height,
    required String weight,
    required String age,
  }) {
    user = user.copyWith(
      height: height,
      weight: weight,
      age: age,
    );
    notifyListeners();
  }

  /// Atualiza a condição física / restrições de saúde e notifica os ouvintes.
  void updateHealthCondition(String value) {
    healthCondition = value;
    notifyListeners();
  }

  /// Atualiza o horário do lembrete diário de exercícios e notifica os ouvintes.
  void updateReminderTime(String value) {
    reminderTime = value;
    notifyListeners();
  }
}
