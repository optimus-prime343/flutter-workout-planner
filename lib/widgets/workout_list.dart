import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workout_planner/providers/workouts_provider.dart';

import '../models/workout_model.dart';
import '../screens/workout_detail_screen.dart';

class WorkoutList extends ConsumerWidget {
  final List<Workout> workouts;
  const WorkoutList({
    super.key,
    required this.workouts,
  });

  @override
  Widget build(BuildContext context, ref) {
    void handleNavigateToDetailScreen(String workoutId) {
      Navigator.of(context).pushNamed(
        WorkoutDetailScreen.routeName,
        arguments: WorkoutDetailScreenArguments(workoutId: workoutId),
      );
    }

    void handleDeleteWorkout(String workoutId) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Workout'),
            content:
                const Text('Are you sure you want to delete this workout?'),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(workoutsProvider.notifier).deleteWorkout(workoutId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Workout deleted'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        Workout workout = workouts[index];
        return ListTile(
          onTap: () => handleNavigateToDetailScreen(workout.id),
          tileColor: Colors.grey.shade800.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              workout.imageUrl,
              width: 80.0,
              height: 80.0,
            ),
          ),
          title: Text(workout.title),
          subtitle: Text(
            workout.description,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => handleDeleteWorkout(workout.id),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemCount: workouts.length,
    );
  }
}
