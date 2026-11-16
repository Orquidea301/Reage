import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../widgets/app_widgets.dart';
import 'goals_screen.dart';
import 'profile_screen.dart';
import 'register_screen.dart';

/// [LoginScreen] é o ecrã de autenticação e entrada no aplicativo ReAge.
/// Utiliza o [AuthScaffold] padronizado com campos de e-mail e senha.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores de texto para e-mail e senha
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Libera os controladores da memória ao destruir o widget
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Retorna a tela inicial correta dependendo do estado do onboarding
  Widget _getHomeWidget() {
    final state = AppState.instance;
    if (state.assessmentDone) {
      return ProfileScreen(
        userName: state.shownName,
        userHeight: '${state.height.toStringAsFixed(2)} m',
        userWeight: '${state.weight.toStringAsFixed(1)} kg',
        userAge: '${state.age} anos',
        emergencyContact: state.contact,
      );
    } else {
      return GoalsScreen(userName: state.registerName);
    }
  }

  // Valida e processa a tentativa de login via AppState
  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha o e-mail e a senha.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await AppState.instance.login(email, password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => _getHomeWidget()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Bem-vindo de volta',
      subtitle: 'Entre para continuar seu plano pessoal.',
      children: [
        LabeledField(
          label: 'E-mail',
          controller: _emailController,
          hint: 'seu.email@exemplo.com',
          keyboardType: TextInputType.emailAddress,
          suggestions: false,
        ),
        const SizedBox(height: 16),
        LabeledField(
          label: 'Senha',
          controller: _passwordController,
          hint: 'Sua senha',
          password: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _isLoading ? null : _handleLogin(),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: _isLoading ? 'Entrando...' : 'Entrar',
          onPressed: _isLoading ? null : _handleLogin,
        ),
        const SizedBox(height: 12),
        Center(
          child: AuthLink(
            question: 'Não tem uma conta? ',
            action: 'Criar conta',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
