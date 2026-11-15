import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/app_widgets.dart';

/// Página de teste temporária para visualizar os novos componentes do ReAge.
class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  double _ageValue = 65.0;
  String _dropdownValue = 'Opção 1';
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _multiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Preview de Componentes - ReAge'),
        backgroundColor: AppColors.primaryYellow,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('1. AppCard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const AppCard(
            child: Text('Este é o conteúdo dentro de um AppCard.'),
          ),
          const SizedBox(height: 24),

          const Text('2. NoticeBox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const NoticeBox(
            text: 'Antes de iniciar atividades físicas, consulte um profissional de saúde.',
          ),
          const SizedBox(height: 24),

          const Text('3. PrimaryButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          PrimaryButton(
            label: 'Botão Primário Ativo',
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          const PrimaryButton(
            label: 'Botão Primário Desativado',
            onPressed: null,
          ),
          const SizedBox(height: 24),

          const Text('4. SecondaryButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          SecondaryButton(
            label: 'Botão Secundário Normal',
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            label: 'Botão com Ícone',
            icon: Icons.close,
            onPressed: () {},
          ),
          const SizedBox(height: 24),

          const Text('5. LogoMark', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          const Center(child: LogoMark(size: 64)),
          const SizedBox(height: 24),

          const Text('6. LabeledField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          LabeledField(
            label: 'Nome Completo',
            controller: _textFieldController,
            hint: 'Digite seu nome',
          ),
          const SizedBox(height: 16),
          LabeledField(
            label: 'Senha',
            controller: _passwordController,
            hint: 'Digite sua senha',
            password: true,
          ),
          const SizedBox(height: 16),
          LabeledField(
            label: 'Observações (Multilinha)',
            controller: _multiController,
            hint: 'Escreva algo...',
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          const Text('7. LabeledDropdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          LabeledDropdown(
            label: 'Selecione uma opção',
            value: _dropdownValue,
            options: const ['Opção 1', 'Opção 2', 'Opção 3'],
            onChanged: (val) {
              setState(() {
                _dropdownValue = val;
              });
            },
          ),
          const SizedBox(height: 24),

          const Text('8. MetricSlider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          MetricSlider(
            label: 'Idade',
            valueText: '${_ageValue.toInt()} anos',
            value: _ageValue,
            min: 50,
            max: 100,
            divisions: 50,
            onChanged: (val) {
              setState(() {
                _ageValue = val;
              });
            },
          ),
          const SizedBox(height: 24),

          const Text('9. AuthScaffold (Abrir Tela)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          PrimaryButton(
            label: 'Abrir AuthScaffold de Exemplo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthScaffold(
                    title: 'Comece a se cuidar',
                    subtitle: 'Crie uma conta para montar seu plano pessoal.',
                    children: [
                      const LabeledField(
                        label: 'E-mail',
                        hint: 'seu.email@exemplo.com',
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Continuar',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: AuthLink(
                          question: 'Já tem uma conta?',
                          action: 'Entrar',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
