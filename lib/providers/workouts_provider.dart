import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout_model.dart';

class WorkoutsNotifier extends StateNotifier<List<Workout>> {
  WorkoutsNotifier() : super([]);

  void saveWorkoutsToStorage(List<Workout> workouts) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(
      'workouts',
      workouts.map((workout) => workout.toJson()).toList(),
    );
  }

  Future<List<Workout>> loadWorkoutsFromStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> workoutsJson = preferences.getStringList('workouts') ?? [];
    state = workoutsJson.map((workout) => Workout.fromJson(workout)).toList();
    return state;
  }

  void addWorkout(Workout workout) {
    state = [...state, workout];
    saveWorkoutsToStorage(state);
  }

  void deleteWorkout(String id) {
    state = state.where((workout) => workout.id != id).toList();
    saveWorkoutsToStorage(state);
  }
}

final workoutsProvider =
    StateNotifierProvider<WorkoutsNotifier, List<Workout>>((ref) {
  return WorkoutsNotifier();
});
