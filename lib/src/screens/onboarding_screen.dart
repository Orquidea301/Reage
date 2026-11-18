import 'package:flutter/material.dart';
import 'package:idosos/src/constants/colors.dart';
import 'package:idosos/src/screens/menu_screen.dart'; // Ou a sua rota principal do menu

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Variáveis para guardar as respostas do utilizador
  String _selectedMotivation = 'Ficar mais forte e independente';
  String _selectedActivityLevel = 'Faço atividades leves regularmente';

  // Múltipla escolha para os desconfortos corporais
  final Map<String, bool> _bodyDiscomforts = {
    'Nenhum desconforto': false,
    'Joelhos': true,
    'Parte inferior das costas': true,
    'Ombros': false,
    'Tornozelos / Pulsação': false,
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho com indicador de passo e botão voltar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  else
                    const SizedBox(width: 40),
                  Text(
                    _getStepTitleIndicator(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontFamily: 'Times New Roman',
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Conteúdo dos Passos em PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [_buildStepOne(), _buildStepTwo(), _buildStepThree()],
              ),
            ),

            // Botão Inferior (Próximo / Gerar Plano)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_currentStep < 2) {
                      setState(() {
                        _currentStep++;
                      });
                      _pageController.animateToPage(
                        _currentStep,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // AQUI É FEITA A ADAPTAÇÃO:
                      // Pode passar as respostas (_selectedMotivation,
                      // _selectedActivityLevel, _bodyDiscomforts)
                      // para o seu gestor de estado ou ecrã principal
                      // para moldar os treinos.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(
                            userName: 'Utilizador', // Adapte para a variável do nome se tiver guardado
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentStep == 2 ? 'GERAR MEU PLANO DE TREINO' : 'PRÓXIMO',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Times New Roman',
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitleIndicator() {
    switch (_currentStep) {
      case 0:
        return '01 • META E FOCO';
      case 1:
        return '02 • AVALIAÇÃO FÍSICA';
      case 2:
        return '03 • AVALIAÇÃO FÍSICA';
      default:
        return '';
    }
  }

  // PASSO 1: O que mais motiva você?
  Widget _buildStepOne() {
    final options = [
      'Melhorar minha saúde e mobilidade',
      'Ficar mais forte e independente',
      'Aumentar minha energia diária',
      'Aliviar dores e o estresse',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'O que mais motiva você?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              fontFamily: 'Times New Roman',
            ),
          ),
          const SizedBox(height: 24),
          ...options.map((option) {
            bool isSelected = _selectedMotivation == option;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMotivation = option;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryYellow
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.primaryYellow
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // PASSO 2: Qual é o seu nível de atividade física?
  Widget _buildStepTwo() {
    final levels = [
      {'title': 'Quase nenhum exercício', 'subtitle': '(Sedentário/a)'},
      {
        'title': 'Ocasionalmente faço exercícios ou caminho por 30 minutos',
        'subtitle': '',
      },
      {'title': 'Faço atividades leves regularmente', 'subtitle': ''},
      {'title': 'Sou bastante ativo/a no dia a dia', 'subtitle': ''},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Qual é o seu nível de atividade física?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              fontFamily: 'Times New Roman',
            ),
          ),
          const SizedBox(height: 24),
          ...levels.map((item) {
            String fullText = '${item['title']} ${item['subtitle']}';
            bool isSelected =
                _selectedActivityLevel == item['title'] ||
                _selectedActivityLevel == fullText;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedActivityLevel = item['title']!;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryYellow
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.primaryYellow
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          if (item['subtitle']!.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              item['subtitle']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // PASSO 3: Algum desconforto ou preocupação com seu corpo?
  Widget _buildStepThree() {
    final discomforts = [
      {
        'key': 'Nenhum desconforto',
        'desc': 'Estou pronto para qualquer exercício leve',
      },
      {'key': 'Joelhos', 'desc': 'Evitar impactos e agachamentos profundos'},
      {
        'key': 'Parte inferior das costas',
        'desc': 'Evitar rotações bruscas e cargas na coluna',
      },
      {'key': 'Ombros', 'desc': 'Evitar exercícios com braços acima da cabeça'},
      {'key': 'Tornozelos / Pulsação', 'desc': 'Foco em estabilidade e apoio'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Algum desconforto ou preocupação com seu corpo?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              fontFamily: 'Times New Roman',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Isso nos ajuda a personalizar os treinos com máxima segurança.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Times New Roman',
            ),
          ),
          const SizedBox(height: 20),
          ...discomforts.map((item) {
            String key = item['key']!;
            bool isChecked = _bodyDiscomforts[key] ?? false;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _bodyDiscomforts[key] = !isChecked;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isChecked
                        ? AppColors.primaryYellow
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: AppColors.primaryYellow,
                      checkColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          _bodyDiscomforts[key] = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['desc']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
