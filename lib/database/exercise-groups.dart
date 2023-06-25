import 'package:flutter/material.dart';

import '../main.dart';

class ExerciseGroup {
  final int id;
  final String name;

  ExerciseGroup({
    required this.id,
    required this.name,
  });
}

class Exercise {
  final int id;
  final int groupId;
  final String name;
  final String description;
  final String example;
  final String constraint;
  final String hint;
  final String solution;

  Exercise({
    required this.id,
    required this.groupId,
    required this.name,
    required this.description,
    required this.example,
    required this.constraint,
    required this.hint,
    required this.solution,
  });
}

class ExerciseGroupProvider extends ChangeNotifier {
  final List<ExerciseGroup> _exerciseGroups = [];
  List<ExerciseGroup> get exerciseGroups => _exerciseGroups;

  Future<List<ExerciseGroup>> fetchExerciseGroups() async {
    // Fetch courses from Supabase
    try {
      final response = await supabase.from('ExerciseGroups').select();
      List<dynamic> data = response;
      for (var item in data) {
        ExerciseGroup group =
            ExerciseGroup(id: item['id'], name: item['group_name']);
        _exerciseGroups.add(group);
      }
      //print(_exerciseGroups);
    } catch (error) {
      // Handle error
    }

    notifyListeners();
    return _exerciseGroups;
  }
}

class ExerciseProvider extends ChangeNotifier {
  final List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  Future<List<Exercise>> fetchExercises() async {
    // Fetch courses from Supabase
    try {
      final response = await supabase.from('Exercises').select();
      List<dynamic> data = response;
      for (var item in data) {
        Exercise exercise = Exercise(
            id: item['id'],
            groupId: item['group_id'],
            name: item['exercise_name'],
            description: item['exercise_description'],
            example: item['exercise_example'],
            constraint: item['exercise_constraint'],
            hint: item['exercise_hint'],
            solution: item['exercise_solution']);
        _exercises.add(exercise);
      }
    } catch (error) {
      // Handle error
    }

    notifyListeners();
    return _exercises;
  }
}
