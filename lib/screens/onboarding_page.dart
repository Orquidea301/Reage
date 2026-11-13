import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// [OnboardingPage] é o ecrã de introdução e boas-vindas do ReAge.
/// Utiliza o pacote `introduction_screen` para apresentar slides explicativos
/// com texto ampliado e cores de alto contraste adequadas para o público idoso.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,

      // Definição das páginas informativas do fluxo inicial
      pages: [
        // Página 1: Boas-vindas geral ao aplicativo
        PageViewModel(
          title: "Bem-vindo ao App",
          body: "Acompanhe seus dados de saúde de forma simples e prática.",
          image: const Center(
            child: Icon(
              Icons.fitness_center,
              size: 100.0,
              color: Colors.orange,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),

        // Página 2: Monitorização do perfil físico
        PageViewModel(
          title: "Monitore seu Perfil",
          body: "Visualize rapidamente informações como Altura, Peso e Idade.",
          image: const Center(
            child: Icon(Icons.person, size: 100.0, color: Colors.orange),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),

        // Página 3: Acesso à conta e gestão de dados
        PageViewModel(
          title: "Faça seu Login",
          body: "Entre na sua conta para salvar e gerenciar suas informações.",
          image: const Center(
            child: Icon(Icons.login, size: 100.0, color: Colors.orange),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),
      ],

      // Ação ao concluir todos os passos do onboarding (redireciona para o Login)
      onDone: () {
        Navigator.pushReplacementNamed(context, '/login');
      },

      // Ação ao clicar em "Pular" (vai direto para o Login)
      onSkip: () {
        Navigator.pushReplacementNamed(context, '/login');
      },

      showSkipButton: true,
      skip: const Text(
        "Pular",
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.orange),
      done: const Text(
        "Entrar",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
      ),

      // Estilização dos indicadores de páginas (pontinhos inferiores)
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.orange,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
