import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';
import 'package:idosos/widgets/app_widgets.dart';

import 'weight_screen.dart';

/// [BodyConcernScreen] corresponde à etapa 03 de avaliação física.
/// Permite selecionar eventuais desconfortos corporais.
class BodyConcernScreen extends StatefulWidget {
  final String userName;

  const BodyConcernScreen({super.key, required this.userName});

  @override
  State<BodyConcernScreen> createState() => _BodyConcernScreenState();
}

class _BodyConcernScreenState extends State<BodyConcernScreen> {
  // Lista para guardar múltiplos desconfortos selecionados pelo idoso
  final List<String> _selectedConcerns = [];

  // Lista de opções de desconfortos (sem subtítulos conforme a versão web)
  final List<String> _concerns = [
    'Nenhum desconforto',
    'Joelhos',
    'Parte inferior das costas',
    'Ombros',
    'Tornozelos / Pulsação',
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
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Algum desconforto ou preocupação com seu corpo?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 20),

              // Lista de opções de seleção múltipla
              Expanded(
                child: ListView.builder(
                  itemCount: _concerns.length,
                  itemBuilder: (context, index) {
                    final concern = _concerns[index];
                    final isSelected = _selectedConcerns.contains(concern);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: InkWell(
                        onTap: () => _toggleSelection(concern),
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
                                child: Text(
                                  concern,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
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

              // Botão Continuar padronizado e aviso de saúde
              PrimaryButton(
                label: 'Continuar',
                onPressed: _selectedConcerns.isNotEmpty
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WeightScreen(userName: widget.userName),
                          ),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 16),
              const NoticeBox(
                text: 'Antes de iniciar atividades físicas, consulte um profissional de saúde.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
