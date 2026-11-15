/// Funções utilitárias de formatação com vírgula como separador decimal.

/// Formata altura (ex: 1,72 m)
String fmtHeight(double value) {
  return '${value.toStringAsFixed(2).replaceAll('.', ',')} m';
}

/// Formata peso com 1 casa decimal (ex: 84,0 kg)
String fmtWeightDecimal(double value) {
  return '${value.toStringAsFixed(1).replaceAll('.', ',')} kg';
}

/// Formata peso de forma curta se inteiro (ex: 84 kg), senão decimal
String fmtWeightShort(double value) {
  if (value == value.truncateToDouble()) {
    return '${value.toInt()} kg';
  }
  return fmtWeightDecimal(value);
}

/// Formata IMC com 1 casa decimal e vírgula
String fmtImc(double value) {
  return value.toStringAsFixed(1).replaceAll('.', ',');
}

/// Formata data no formato dd/MM/aaaa
String fmtDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  return '$day/$month/$year';
}
