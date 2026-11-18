/// [ReportController] é uma classe de pura lógica Dart responsável por processar
/// os cálculos de IMC e categorização de saúde baseados nas medidas corporais.
class ReportController {
  final String userWeight;
  final String userHeight;
  final String userAge;

  ReportController({
    required this.userWeight,
    required this.userHeight,
    required this.userAge,
  });

  /// Calcula o Índice de Massa Corporal (IMC) com base no peso e altura informados.
  double get bmi {
    try {
      final weight = double.parse(
        userWeight.replaceAll(RegExp(r'[^0-9.]'), ''),
      );
      final height = double.parse(
        userHeight.replaceAll(RegExp(r'[^0-9.]'), ''),
      );
      if (height > 0) {
        return weight / (height * height);
      }
    } catch (_) {}
    return 0.0;
  }

  /// Retorna a categoria textual do IMC calculada.
  String get category {
    final currentBmi = bmi;
    if (currentBmi == 0) return 'Não calculado';
    if (currentBmi < 18.5) return 'Abaixo do peso';
    if (currentBmi < 25.0) return 'Peso Saudável (Ideal)';
    if (currentBmi < 30.0) return 'Sobrepeso leve';
    return 'Requer atenção médica';
  }

  /// Retorna o texto formatado do IMC (com 1 casa decimal ou '--' se 0).
  String get formattedBmi {
    final currentBmi = bmi;
    return currentBmi > 0 ? currentBmi.toStringAsFixed(1) : '--';
  }
}
