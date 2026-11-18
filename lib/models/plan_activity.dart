/// [PlanActivity] representa uma atividade do plano pessoal de 28 dias.
class PlanActivity {
  final String title;
  final String subtitle;
  bool done;

  PlanActivity({
    required this.title,
    required this.subtitle,
    this.done = false,
  });
}
