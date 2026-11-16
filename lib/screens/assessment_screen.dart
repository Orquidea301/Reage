import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/assessment_data.dart';
import '../services/app_state.dart';
import '../utils/format.dart';
import '../widgets/app_widgets.dart';
import '../constants/app_theme.dart';
import '../constants/colors.dart';
import 'profile_screen.dart';

/// [AssessmentScreen] é o fluxo unificado de avaliação inicial (9 perguntas + etapa final).
class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  late int _step;
  final ScrollController _scrollController = ScrollController();

  // Estados da etapa final (medidas e dados do idoso)
  late int _age;
  late double _height;
  late double _weight;
  late final TextEditingController _nameController;
  late final TextEditingController _emergencyController;

  @override
  void initState() {
    super.initState();
    _step = _getInitialStep();
    final state = AppState.instance;
    _age = state.age;
    _height = state.height;
    _weight = state.weight;
    _nameController = TextEditingController(
      text: state.elderName.isNotEmpty ? state.elderName : state.registerName,
    );
    _emergencyController = TextEditingController(text: state.contact);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }

  // Determina a etapa inicial: primeira pergunta sem resposta ou etapa final (9) se todas respondidas
  int _getInitialStep() {
    final answers = AppState.instance.answers;
    for (int i = 0; i < AssessmentData.questions.length; i++) {
      if (!answers.containsKey(i)) {
        return i;
      }
    }
    return 9;
  }

  // Processa o botão Continuar / Concluir Avaliação
  void _handleNext() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_step < 9) {
      if (!AppState.instance.answers.containsKey(_step)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Escolha uma opção para continuar.')),
        );
        return;
      }
      setState(() {
        _step++;
      });
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Etapa final: validação do telefone de emergência
      final emergencyText = _emergencyController.text.trim();
      final emergencyDigits = emergencyText.replaceAll(RegExp(r'\D'), '');

      if (emergencyDigits.isNotEmpty && emergencyDigits.length != 10 && emergencyDigits.length != 11) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite um telefone válido, com DDD.')),
        );
        return;
      }

      final name = _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : AppState.instance.registerName;

      AppState.instance.finishAssessment(
        name: name,
        emergencyContact: emergencyDigits,
        ageValue: _age,
        heightValue: _height,
        weightValue: _weight,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            userName: AppState.instance.shownName,
            userHeight: fmtHeight(_height),
            userWeight: fmtWeightDecimal(_weight),
            userAge: '$_age anos',
            emergencyContact: AppState.instance.contact,
          ),
        ),
        (route) => false,
      );
    }
  }

  // Processa o botão Voltar
  void _handleBack() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _step > 0) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundCream,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A5A4A2A),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // a) Eyebrow
                      Text(
                        'AVALIAÇÃO INICIAL · ${_step + 1} DE 10',
                        style: AppText.eyebrow,
                      ),
                      const SizedBox(height: 12),
                      // b) Barra de progresso
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (_step + 1) / 10,
                          minHeight: 10,
                          backgroundColor: AppColors.progressTrack,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryYellow,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      // c) Título
                      Text(
                        _step < 9
                            ? AssessmentData.questions[_step].title
                            : 'Conte-nos um pouco sobre você',
                        textAlign: TextAlign.center,
                        style: AppText.title.copyWith(fontSize: 26),
                      ),
                      // d) Subtítulo só na etapa final
                      if (_step == 9) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Deslize as barras para ajustar seus dados.',
                          textAlign: TextAlign.center,
                          style: AppText.caption,
                        ),
                      ],
                      const SizedBox(height: 22),
                      // e) Conteúdo (Perguntas ou Sliders/Campos)
                      if (_step < 9) ...[
                        ...List.generate(
                          AssessmentData.questions[_step].options.length,
                          (optionIndex) {
                            final optionText =
                                AssessmentData.questions[_step].options[optionIndex];
                            final isSelected =
                                AppState.instance.answers[_step] == optionIndex;

                            return Semantics(
                              selected: isSelected,
                              inMutuallyExclusiveGroup: true,
                              button: true,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      AppState.instance.setAnswer(_step, optionIndex);
                                      setState(() {});
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      constraints: const BoxConstraints(minHeight: 60),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.selected
                                            : AppColors.field,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.selectedBorder
                                              : AppColors.grayBorder,
                                          width: isSelected ? 1.5 : 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isSelected
                                                    ? AppColors.primaryYellow
                                                    : AppColors.ringBorder,
                                                width: 2,
                                              ),
                                            ),
                                            child: isSelected
                                                ? Center(
                                                    child: Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.primaryYellow,
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Text(
                                              optionText,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? AppColors.textDark
                                                    : AppColors.textBody,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ] else ...[
                        // Etapa final: Sliders e Campos
                        MetricSlider(
                          label: 'Idade',
                          valueText: '$_age anos',
                          value: _age.toDouble(),
                          min: AssessmentData.minAge.toDouble(),
                          max: AssessmentData.maxAge.toDouble(),
                          divisions: 50,
                          onChanged: (val) {
                            setState(() {
                              _age = val.round();
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        MetricSlider(
                          label: 'Altura',
                          valueText: fmtHeight(_height),
                          value: _height,
                          min: AssessmentData.minHeight,
                          max: AssessmentData.maxHeight,
                          divisions: 80,
                          onChanged: (val) {
                            setState(() {
                              _height = double.parse(val.toStringAsFixed(2));
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        MetricSlider(
                          label: 'Peso',
                          valueText: fmtWeightDecimal(_weight),
                          value: _weight,
                          min: AssessmentData.minWeight,
                          max: AssessmentData.maxWeight,
                          divisions: 230,
                          onChanged: (val) {
                            setState(() {
                              _weight = (val * 2).round() / 2.0;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        LabeledField(
                          label: 'Nome do idoso',
                          hint: 'Digite o nome',
                          capitalization: TextCapitalization.words,
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),
                        LabeledField(
                          label: 'Contato de emergência',
                          hint: 'Telefone',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          controller: _emergencyController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                      ],
                      const SizedBox(height: 12),
                      // f) Botões Voltar e Continuar / Concluir Avaliação
                      Row(
                        children: [
                          SecondaryButton(
                            label: 'Voltar',
                            onPressed: _step == 0 ? null : _handleBack,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              label: _step == 9
                                  ? 'CONCLUIR AVALIAÇÃO'
                                  : 'Continuar',
                              onPressed: _handleNext,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // g) Aviso de saúde
                      const NoticeBox(
                        text:
                            'Antes de iniciar atividades físicas, consulte um profissional de saúde.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
