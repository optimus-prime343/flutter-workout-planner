import 'package:flutter/material.dart';

import '../models/workout_model.dart';

class ExerciseList extends StatelessWidget {
  final Function(List<Exercise>) onExerciesReorder;
  final Function(String id) onExerciseDelete;
  final List<Exercise> exercises;

  const ExerciseList({
    super.key,
    required this.exercises,
    required this.onExerciesReorder,
    required this.onExerciseDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: exercises.length * 60.0,
      child: ReorderableListView.builder(
        itemBuilder: (context, index) {
          Exercise exercise = exercises[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            key: ValueKey(exercise.id),
            title: Text(exercise.name),
            leading: IconButton(
              onPressed: () {
                onExerciseDelete(exercise.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            trailing: const Icon(Icons.drag_handle),
          );
        },
        itemCount: exercises.length,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          List<Exercise> excersiseCopy = [...exercises];
          excersiseCopy.insert(newIndex, excersiseCopy.removeAt(oldIndex));
          onExerciesReorder(excersiseCopy);
        },
      ),
    );
  }
}
