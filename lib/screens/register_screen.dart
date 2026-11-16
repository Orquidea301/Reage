import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../widgets/app_widgets.dart';
import 'assessment_screen.dart';

/// [RegisterScreen] é o ecrã de registo de novos utilizadores no ReAge.
/// Utiliza o [AuthScaffold] e realiza validações completas dos dados.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const bool _pedirConfirmacao = true;
  static const int _minimoSenha = 8;
  static const List<String> _perfis = ['O próprio idoso', 'Familiar', 'Médico'];

  // Controladores de texto do formulário
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Estado do dropdown de perfil e carregamento
  String _selectedPerfil = _perfis.first;
  bool _isLoading = false;

  @override
  void dispose() {
    // Libera os controladores ao destruir o widget
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Valida os dados inseridos, regista no AppState e avança para AssessmentScreen
  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // a) Validação de campos vazios
    if (name.isEmpty || email.isEmpty || password.isEmpty || (_pedirConfirmacao && confirm.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    // b) Validação do formato do e-mail
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um e-mail válido.')),
      );
      return;
    }

    // c) Validação do tamanho mínimo da senha
    if (password.length < _minimoSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('A senha precisa ter no mínimo $_minimoSenha caracteres.')),
      );
      return;
    }

    // d) Validação de confirmação de senha (se aplicável)
    if (_pedirConfirmacao && password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await AppState.instance.register(
      name: name,
      emailAddress: email,
      password: password,
      accountRole: _selectedPerfil,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // Avança para AssessmentScreen limpando a pilha com pushAndRemoveUntil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AssessmentScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Comece a se cuidar',
      subtitle: 'Crie uma conta para montar seu plano pessoal.',
      children: [
        LabeledField(
          label: 'Como quer ser chamado?',
          controller: _nameController,
          hint: 'Seu nome',
          keyboardType: TextInputType.name,
          capitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        LabeledField(
          label: 'E-mail',
          controller: _emailController,
          hint: 'seu.email@exemplo.com',
          keyboardType: TextInputType.emailAddress,
          suggestions: false,
        ),
        const SizedBox(height: 16),
        LabeledField(
          label: 'Senha (mínimo de $_minimoSenha caracteres)',
          controller: _passwordController,
          hint: 'Sua senha',
          password: true,
          textInputAction: _pedirConfirmacao ? TextInputAction.next : TextInputAction.done,
        ),
        if (_pedirConfirmacao) ...[
          const SizedBox(height: 16),
          LabeledField(
            label: 'Confirmar senha',
            controller: _confirmPasswordController,
            hint: 'Confirme sua senha',
            password: true,
            textInputAction: TextInputAction.done,
          ),
        ],
        const SizedBox(height: 16),
        LabeledDropdown(
          label: 'Quem está cadastrando?',
          value: _selectedPerfil,
          options: _perfis,
          onChanged: (val) {
            setState(() {
              _selectedPerfil = val;
            });
          },
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: _isLoading ? 'Criando...' : 'Criar conta',
          onPressed: _isLoading ? null : _handleRegister,
        ),
        const SizedBox(height: 12),
        Center(
          child: AuthLink(
            question: 'Já tem uma conta? ',
            action: 'Entrar',
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
        ),
      ],
    );
  }
}
