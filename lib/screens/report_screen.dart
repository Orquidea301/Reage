import 'package:flutter/material.dart';
import 'package:idosos/constants/colors.dart';

import 'history_screen.dart'; // Importa o ecrã de histórico de 28 dias

/// [ReportScreen] exibe o relatório detalhado de saúde do utilizador no ReAge.
/// Inclui o cálculo dinâmico do IMC, resumo de treinos, frequência semanal
/// interativa e histórico de atividades recentes, totalmente responsivo e sem overflow.
class ReportScreen extends StatefulWidget {
  final String userWeight;
  final String userHeight;
  final String userAge;

  const ReportScreen({
    super.key,
    required this.userWeight,
    required this.userHeight,
    required this.userAge,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // Cálculo seguro do IMC com base nos dados do usuário fornecidos
  double _calculateBMI() {
    try {
      final weight = double.parse(
        widget.userWeight.replaceAll(RegExp(r'[^0-9.]'), ''),
      );
      final height = double.parse(
        widget.userHeight.replaceAll(RegExp(r'[^0-9.]'), ''),
      );
      if (height > 0) {
        return weight / (height * height);
      }
    } catch (_) {}
    return 0.0;
  }

  // Retorna a categoria textual do IMC adaptada
  String _getBMICategory(double bmi) {
    if (bmi == 0) return 'Não calculado';
    if (bmi < 18.5) return 'Abaixo do peso';
    if (bmi < 25.0) return 'Peso Saudável (Ideal)';
    if (bmi < 30.0) return 'Sobrepeso leve';
    return 'Requer atenção médica';
  }

  @override
  Widget build(BuildContext context) {
    final bmi = _calculateBMI();
    final bmiString = bmi > 0 ? bmi.toStringAsFixed(1) : '--';
    final bmiStatus = _getBMICategory(bmi);

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho Principal do Relatório
              const Text(
                'Meu Relatório de Saúde',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Acompanhe sua evolução e constância diária',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 24),

              // 1. Resumo Rápido de Atividades (Treinos, Calorias, Tempo)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTopMetric('2', 'treinos', Icons.fitness_center),
                    _buildDivider(),
                    _buildTopMetric('120', 'Kcal', Icons.local_fire_department),
                    _buildDivider(),
                    _buildTopMetric('25', 'Minutos', Icons.timer),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Frequência Semanal (Totalmente Interativa e Funcional)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Frequência da Semana',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                        // Botão Histórico interativo que abre o plano pessoal de 28 dias
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Histórico >',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryYellow,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Dias da semana interativos (ao tocar, alterna o estado do dia)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _InteractiveDayIndicator(
                          day: 'Dom',
                          date: '8',
                          initialActive: false,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Seg',
                          date: '9',
                          initialActive: false,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Ter',
                          date: '10',
                          initialActive: true,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Quar',
                          date: '11',
                          initialActive: false,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Quin',
                          date: '12',
                          initialActive: true,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Sex',
                          date: '13',
                          initialActive: false,
                        ),
                        _InteractiveDayIndicator(
                          day: 'Sáb',
                          date: '14',
                          initialActive: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Icon(
                          Icons.local_fire_department,
                          color: AppColors.primaryYellow,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sequência atual: 2 dias seguidos',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. Bloco de Medidas Corporais e IMC (Com dados recolhidos no onboarding)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Suas Medidas e IMC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetricColumn('Altura', widget.userHeight),
                        _buildDivider(),
                        _buildMetricColumn('Peso', widget.userWeight),
                        _buildDivider(),
                        _buildMetricColumn('Idade', widget.userAge),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Seu IMC atual',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bmiString,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryYellow,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryYellow.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            bmiStatus,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Atividades Recentes
              const Text(
                'Atividades Recentes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 12),
              _buildActivityCard(
                'Mobilidade e Articulações',
                'Hoje • 12 min',
                'Concluído',
              ),
              const SizedBox(height: 12),
              _buildActivityCard(
                'Equilíbrio e Postura',
                'Ontem • 15 min',
                'Excelente',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói uma métrica de resumo no topo
  Widget _buildTopMetric(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryYellow, size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            fontFamily: 'Times New Roman',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontFamily: 'Times New Roman',
          ),
        ),
      ],
    );
  }

  // Constrói uma coluna de medida corporal individual
  Widget _buildMetricColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Times New Roman',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            fontFamily: 'Times New Roman',
          ),
        ),
      ],
    );
  }

  // Linha divisora vertical para separar métricas
  Widget _buildDivider() {
    return Container(height: 35, width: 1, color: Colors.grey.shade300);
  }

  // Constrói um cartão de atividade recente concluída
  Widget _buildActivityCard(String title, String subtitle, String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget auxiliar interativo para os dias da semana
class _InteractiveDayIndicator extends StatefulWidget {
  final String day;
  final String date;
  final bool initialActive;

  const _InteractiveDayIndicator({
    required this.day,
    required this.date,
    required this.initialActive,
  });

  @override
  State<_InteractiveDayIndicator> createState() =>
      _InteractiveDayIndicatorState();
}

class _InteractiveDayIndicatorState extends State<_InteractiveDayIndicator> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.initialActive;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
      },
      child: Column(
        children: [
          Text(
            widget.day,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.textDark : Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.primaryYellow : Colors.grey.shade200,
            ),
            child: Center(
              child: Text(
                widget.date,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.grey.shade700,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
