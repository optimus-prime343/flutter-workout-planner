import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_model.dart';
import '../providers/workouts_provider.dart';

class WorkoutDetailScreenArguments {
  final String workoutId;

  WorkoutDetailScreenArguments({
    required this.workoutId,
  });
}

class WorkoutDetailScreen extends ConsumerWidget {
  static const routeName = '/workout-detail';

  const WorkoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    WorkoutDetailScreenArguments workoutDetailScreenArguments =
        ModalRoute.of(context)!.settings.arguments
            as WorkoutDetailScreenArguments;
    String workoutId = workoutDetailScreenArguments.workoutId;
    Workout workout = ref.watch(workoutsProvider).firstWhere(
          (workout) => workout.id == workoutId,
        );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(workout.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(workout.imageUrl),
              ),
              const SizedBox(height: 16.0),
              Text(
                workout.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12.0),
              Text(
                workout.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24.0),
              Flexible(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Exercise exercise = workout.exercises[index];
                    return Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(exercise.name),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16.0,
                  ),
                  itemCount: workout.exercises.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
