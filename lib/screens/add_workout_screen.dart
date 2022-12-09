import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_model.dart';
import '../providers/workouts_provider.dart';
import '../widgets/add_workout_form.dart';
import 'workout_detail_screen.dart';

class AddWorkoutScreen extends ConsumerWidget {
  const AddWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void handleAddWorkout(Workout workout) {
      ref.read(workoutsProvider.notifier).addWorkout(workout);
      Navigator.of(context).pushNamed(
        WorkoutDetailScreen.routeName,
        arguments: WorkoutDetailScreenArguments(
          workoutId: workout.id,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add new workout')),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 8.0,
          ),
          child: AddWorkoutForm(
            onAddWorkoutFormSubmit: handleAddWorkout,
          ),
        ),
      ),
    );
  }
}
