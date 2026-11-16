/// Funções utilitárias de formatação com ponto como separador decimal.

/// Formata altura (ex: 1.72 m)
String fmtHeight(double value) {
  return '${value.toStringAsFixed(2)} m';
}

/// Formata peso com 1 casa decimal (ex: 84.0 kg)
String fmtWeightDecimal(double value) {
  return '${value.toStringAsFixed(1)} kg';
}

/// Formata peso de forma curta se inteiro (ex: 84 kg), senão decimal
String fmtWeightShort(double value) {
  if (value == value.truncateToDouble()) {
    return '${value.toInt()} kg';
  }
  return fmtWeightDecimal(value);
}

/// Formata IMC com 1 casa decimal e ponto (ex: 28.4)
String fmtImc(double value) {
  return value.toStringAsFixed(1);
}

/// Formata data no formato dd/MM/aaaa
String fmtDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  return '$day/$month/$year';
}

/// Formata número de telefone para (79) 99999-0098 ou (79) 9999-0098
String fmtPhone(String raw) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.length == 11) {
    return '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7, 11)}';
  } else if (digits.length == 10) {
    return '(${digits.substring(0, 2)}) ${digits.substring(2, 6)}-${digits.substring(6, 10)}';
  }
  return raw;
}
