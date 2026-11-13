import 'dart:io';

/// [UserModel] é a classe modelo responsável por estruturar e centralizar
/// todas as informações do perfil do utilizador recolhidas durante o fluxo de onboarding.
/// Esta classe armazena dados essenciais (nome, altura, peso, idade),
/// as preferências de saúde e o ficheiro de imagem de perfil, facilitando
/// a manipulação e transporte de dados entre as telas do aplicativo ReAge.
class UserModel {
  /// Nome completo ou apelido inserido pelo utilizador no início do registo.
  final String name;

  /// Altura atual formatada em metros (ex: "1.65 m").
  final String height;

  /// Peso atual formatado em quilogramas (ex: "70.0 kg").
  final String weight;

  /// Idade atual do utilizador (ex: "65 anos").
  final String age;

  /// Objetivo principal selecionado pelo idoso (ex: Mobilidade, Força, Equilíbrio).
  final String? goal;

  /// Nível de preparação física ou atividade atual do utilizador.
  final String? activityLevel;

  /// Lista opcional com focos corporais ou áreas de maior atenção/cuidado.
  final List<String>? bodyConcerns;

  /// Ficheiro de imagem selecionado da galeria do telemóvel para o avatar do perfil.
  final File? photo;

  /// Construtor principal para instanciar o modelo com os dados obrigatórios e opcionais.
  UserModel({
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    this.goal,
    this.activityLevel,
    this.bodyConcerns,
    this.photo,
  });
}
