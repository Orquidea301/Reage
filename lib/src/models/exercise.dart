/// [Exercise] representa o modelo de dados tipado para cada exercício.
class Exercise {
  final String title;
  final String subtitle;
  final String description;
  final String? image;

  const Exercise({
    required this.title,
    required this.subtitle,
    required this.description,
    this.image,
  });
}
