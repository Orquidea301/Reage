/// [UserModel] representa o modelo de dados imutável do utilizador no ReAge.
class UserModel {
  final String name;
  final String age;
  final String weight;
  final String height;
  final String mainGoal; // Ex: 'Mobilidade', 'Força', 'Equilíbrio'

  const UserModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    this.mainGoal = '',
  });

  /// Retorna uma cópia da instância atual com os campos fornecidos substituídos.
  UserModel copyWith({
    String? name,
    String? age,
    String? weight,
    String? height,
    String? mainGoal,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      mainGoal: mainGoal ?? this.mainGoal,
    );
  }
}
