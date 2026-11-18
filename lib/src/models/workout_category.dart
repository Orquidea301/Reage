import 'package:flutter/material.dart';
import 'exercise.dart';

/// [WorkoutCategory] representa o modelo de dados para categorias de treino.
class WorkoutCategory {
  final String title;
  final String subtitle;
  final String? level;
  final IconData icon;
  final List<Exercise> exercises;

  const WorkoutCategory({
    required this.title,
    required this.subtitle,
    this.level,
    required this.icon,
    required this.exercises,
  });
}
