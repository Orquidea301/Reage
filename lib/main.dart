import 'package:flutter/material.dart';

import 'constants/app_theme.dart';
// import 'screens/login_screen.dart'; // Importa a tela de login
import 'screens/preview_page.dart';

/// Ponto de entrada principal da aplicação ReAge.
void main() {
  runApp(const ReAgeApp());
}

/// [ReAgeApp] é o widget raiz da aplicação.
/// Define as configurações globais de tema, cores padronizadas,
/// tipografia e o ecrã inicial (`LoginScreen`).
class ReAgeApp extends StatelessWidget {
  const ReAgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReAge',
      // Remove a faixa vermelha de "Debug" no canto superior direito
      debugShowCheckedModeBanner: false,

      // Configuração do tema global com as cores e padrões do ReAge
      theme: AppTheme.light,

      // Define o ecrã inicial ao abrir a aplicação
      // home: const LoginScreen(),
      home: const PreviewPage(),
    );
  }
}
