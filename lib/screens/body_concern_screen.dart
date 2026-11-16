import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';

import 'weight_screen.dart';

class BodyConcernScreen extends StatefulWidget {
  final String userName;
  final String selectedGoal;
  final String activityLevel;

  const BodyConcernScreen({
    super.key,
    required this.userName,
    required this.selectedGoal,
    required this.activityLevel,
  });

  @override
  State<BodyConcernScreen> createState() => _BodyConcernScreenState();
}

class _BodyConcernScreenState extends State<BodyConcernScreen> {
  // Lista para guardar múltiplos desconfortos selecionados
  final List<String> _selectedConcerns = [];

  // Lista de opções de desconfortos
  final List<Map<String, String>> _concerns = [
    {
      'title': 'Nenhum desconforto',
      'subtitle': 'Estou pronto para qualquer exercício leve',
    },
    {
      'title': 'Joelhos',
      'subtitle': 'Evitar impactos e agachamentos profundos',
    },
    {
      'title': 'Parte inferior das costas',
      'subtitle': 'Evitar rotações bruscas e cargas na coluna',
    },
    {
      'title': 'Ombros',
      'subtitle': 'Evitar exercícios com braços acima da cabeça',
    },
    {
      'title': 'Tornozelos / Pulsação',
      'subtitle': 'Foco em estabilidade e apoio',
    },
  ];

  // Controla a seleção dos desconfortos
  void _toggleSelection(String title) {
    setState(() {
      if (title == 'Nenhum desconforto') {
        _selectedConcerns.clear();
        _selectedConcerns.add('Nenhum desconforto');
      } else {
        _selectedConcerns.remove('Nenhum desconforto');

        if (_selectedConcerns.contains(title)) {
          _selectedConcerns.remove(title);
        } else {
          _selectedConcerns.add(title);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '03 • AVALIAÇÃO FÍSICA',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
            const SizedBox(height: 8),
            const Text(
              'Isso nos ajuda a personalizar os treinos com máxima segurança.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Times New Roman',
              ),
            ),
            const SizedBox(height: 20),

            // Lista de opções de seleção múltipla
            Expanded(
              child: ListView.builder(
                itemCount: _concerns.length,
                itemBuilder: (context, index) {
                  final item = _concerns[index];

                  final isSelected = _selectedConcerns.contains(item['title']);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: InkWell(
                      onTap: () => _toggleSelection(item['title']!),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryYellow
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isSelected
                                  ? AppColors.primaryYellow
                                  : Colors.grey,
                              size: 28,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: AppColors.textDark,
                                      fontFamily: 'Times New Roman',
                                    ),
                                  ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botão próximo
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // Se nada foi marcado, assume nenhum desconforto
                  if (_selectedConcerns.isEmpty) {
                    _selectedConcerns.add('Nenhum desconforto');
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeightScreen(
                        userName: widget.userName,
                        selectedGoal: widget.selectedGoal,
                        activityLevel: widget.activityLevel,
                        bodyConcerns: List<String>.from(_selectedConcerns),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'PRÓXIMO',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
