import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_model.dart';
import '../providers/workouts_provider.dart';
import '../widgets/no_workouts_found.dart';
import '../widgets/workout_list.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  WorkoutsScreenState createState() => WorkoutsScreenState();
}

class WorkoutsScreenState extends ConsumerState<WorkoutsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.watch(workoutsProvider.notifier).loadWorkoutsFromStorage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Workout> workouts = ref.watch(workoutsProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your workouts'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: workouts.isEmpty
              ? const NoWorkoutsFound()
              : WorkoutList(workouts: workouts),
        ),
      ),
    );
  }
}
