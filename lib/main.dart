import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/constants/colors.dart';
import 'src/screens/login_screen.dart'; // Importa a tela de login
import 'src/services/notification_service.dart'; // Importa o serviço de notificações

/// Ponto de entrada principal da aplicação ReAge.
void main() async {
  // Garante que os bindings do Flutter estejam prontos antes de chamadas assíncronas nativas
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp();

  // Inicializa o serviço de notificações push
  await NotificationService.initialize();

  runApp(const ReAgeApp());
}

/// [ReAgeApp] é o widget raiz da aplicação.
/// Define as configurações globais de tema, cores padronizadas,
/// tipografia clássica (Times New Roman) e o ecrã inicial (`LoginScreen`).
class ReAgeApp extends StatelessWidget {
  const ReAgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReAge',
      // Remove a faixa vermelha de "Debug" no canto superior direito
      debugShowCheckedModeBanner: false,

      // Configuração do tema global com as novas cores e fontes do ReAge
      theme: ThemeData(
        primaryColor: AppColors.primaryYellow,
        scaffoldBackgroundColor: AppColors.backgroundCream,
        fontFamily: 'Times New Roman', // Fonte alterada para Times
      ),

      // Define o ecrã inicial ao abrir a aplicação
      home: const LoginScreen(),
    );
  }
}
