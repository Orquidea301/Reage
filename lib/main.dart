import 'package:flutter/material.dart';

import 'constants/app_theme.dart';
import 'screens/assessment_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'services/app_state.dart';
import 'utils/format.dart';

/// Ponto de entrada principal da aplicação ReAge.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.load();
  runApp(const ReAgeApp());
}

/// [ReAgeApp] é o widget raiz da aplicação.
/// Define as configurações globais de tema, cores padronizadas,
/// tipografia e o ecrã inicial com base no estado de autenticação e onboarding.
class ReAgeApp extends StatelessWidget {
  const ReAgeApp({super.key});

  Widget _getInitialScreen() {
    final state = AppState.instance;
    if (state.hasAccount && state.loggedIn) {
      if (state.assessmentDone) {
        return ProfileScreen(
          userName: state.shownName,
          userHeight: fmtHeight(state.height),
          userWeight: fmtWeightDecimal(state.weight),
          userAge: '${state.age} anos',
          emergencyContact: state.contact,
        );
      } else {
        return const AssessmentScreen();
      }
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReAge',
      // Remove a faixa vermelha de "Debug" no canto superior direito
      debugShowCheckedModeBanner: false,

      // Configuração do tema global com as cores e padrões do ReAge
      theme: AppTheme.light,

      // Define o ecrã inicial com base no AppState
      home: _getInitialScreen(),
    );
  }
}
