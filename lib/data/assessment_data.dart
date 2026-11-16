/// Representa uma pergunta da avaliação inicial com suas opções.
class AssessmentQuestion {
  final String title;
  final List<String> options;

  const AssessmentQuestion({
    required this.title,
    required this.options,
  });
}

/// Dados estáticos do questionário de avaliação inicial e limites das barras.
class AssessmentData {
  static const int minAge = 50;
  static const int maxAge = 100;
  static const double minHeight = 1.30;
  static const double maxHeight = 2.10;
  static const double minWeight = 35.0;
  static const double maxWeight = 150.0;

  static const List<AssessmentQuestion> questions = [
    AssessmentQuestion(
      title: "Qual é o seu nível de atividade física?",
      options: [
        "Quase nenhum exercício (sedentário/a)",
        "Ocasionalmente faço exercícios ou caminho por 30 minutos",
        "Faço atividades leves regularmente",
        "Sou bastante ativo/a no dia a dia",
      ],
    ),
    AssessmentQuestion(
      title: "O que mais motiva você?",
      options: [
        "Melhorar minha saúde e condicionamento",
        "Ficar mais forte e independente",
        "Aumentar minha energia diária",
        "Aliviar dores e o estresse",
      ],
    ),
    AssessmentQuestion(
      title: "Algum desconforto ou preocupação com seu corpo?",
      options: [
        "Nenhum desconforto",
        "Joelhos",
        "Parte inferior das costas",
        "Ombros",
        "Tornozelos / Pulsação",
      ],
    ),
    AssessmentQuestion(
      title: "Como você avalia sua mobilidade no dia a dia?",
      options: [
        "Consigo me movimentar sem dificuldades",
        "Tenho pequenas dificuldades em alguns movimentos",
        "Preciso de apoio para determinadas atividades",
        "Tenho bastante dificuldade para me movimentar",
      ],
    ),
    AssessmentQuestion(
      title: "Quanto tempo você gostaria de dedicar aos exercícios diariamente?",
      options: [
        "5 a 10 minutos",
        "10 a 15 minutos",
        "15 a 20 minutos",
        "20 a 30 minutos",
      ],
    ),
    AssessmentQuestion(
      title: "Você utiliza algum auxílio para caminhar?",
      options: [
        "Não preciso de auxílio",
        "Utilizo bengala",
        "Utilizo andador",
        "Utilizo cadeira de rodas",
        "Preciso da ajuda de outra pessoa",
      ],
    ),
    AssessmentQuestion(
      title: "Você possui alguma condição de saúde que exige cuidados durante atividades físicas?",
      options: [
        "Não possuo nenhuma condição conhecida",
        "Pressão alta",
        "Diabetes",
        "Problemas cardíacos",
        "Problemas nas articulações",
        "Outra condição de saúde",
      ],
    ),
    AssessmentQuestion(
      title: "Como você se sente ao realizar atividades físicas?",
      options: [
        "Sinto-me bem e disposto(a)",
        "Canso com facilidade",
        "Tenho dificuldades para manter o equilíbrio",
        "Sinto desconforto durante alguns movimentos",
        "Ainda não pratico atividades físicas",
      ],
    ),
    AssessmentQuestion(
      title: "Você já sofreu alguma queda ou tem receio de cair?",
      options: [
        "Nunca sofri quedas e não tenho receio",
        "Já sofri uma queda, mas não tenho dificuldades atualmente",
        "Tenho receio de cair",
        "Sofri quedas recentemente",
        "Preciso de apoio para evitar quedas",
      ],
    ),
  ];
}
