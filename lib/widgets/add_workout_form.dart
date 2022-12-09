import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:uuid/uuid.dart';

import '../models/workout_model.dart';
import '../utils/input_decoration.dart';
import 'exercise_list.dart';

class AddWorkoutForm extends StatefulWidget {
  final void Function(Workout workout) onAddWorkoutFormSubmit;
  const AddWorkoutForm({
    super.key,
    required this.onAddWorkoutFormSubmit,
  });

  @override
  State<AddWorkoutForm> createState() => _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  final Uuid uuid = const Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutTitleController = TextEditingController();
  final TextEditingController _workoutDescriptionController =
      TextEditingController();
  final TextEditingController _workoutImageUrlController =
      TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();

  List<Exercise> _exercises = [];

  void _handleExerciseNameAdd() {
    final String exerciseName = _exerciseNameController.text;
    List<Exercise> exerciseAlreadyExists =
        _exercises.where((exercise) => exercise.name == exerciseName).toList();
    if (exerciseName.isEmpty) return;
    if (exerciseAlreadyExists.isNotEmpty) return;
    final Exercise newExercise = Exercise(id: uuid.v4(), name: exerciseName);
    setState(() {
      _exercises = [..._exercises, newExercise];
    });
    _exerciseNameController.clear();
  }

  void _handleReorderExercises(List<Exercise> exercises) {
    setState(() {
      _exercises = exercises;
    });
  }

  void _handleDeleteExercise(String id) {
    List<Exercise> updatedExercises =
        _exercises.where((exercise) => exercise.id != id).toList();
    setState(() {
      _exercises = updatedExercises;
    });
  }

  void _resetAllFieldAndValues() {
    _workoutTitleController.clear();
    _workoutDescriptionController.clear();
    _workoutImageUrlController.clear();
    _exerciseNameController.clear();
    setState(() {
      _exercises = [];
    });
  }

  void _handleFormSubmit() {
    if (_exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one exercise'),
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      String title = _workoutTitleController.text;
      String description = _workoutDescriptionController.text;
      String imageUrl = _workoutImageUrlController.text;
      Workout newWorkout = Workout(
        id: uuid.v4(),
        title: title,
        description: description,
        imageUrl: imageUrl,
        exercises: _exercises,
      );
      widget.onAddWorkoutFormSubmit(newWorkout);
      _resetAllFieldAndValues();
    }
  }

  @override
  void initState() {
    super.initState();
    _exerciseNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _workoutTitleController.dispose();
    _workoutDescriptionController.dispose();
    _workoutImageUrlController.dispose();
    _exerciseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _workoutTitleController,
            validator: ValidationBuilder().minLength(6).maxLength(50).build(),
            decoration: inputDecoration.copyWith(
              hintText: 'Enter workout title',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: _workoutDescriptionController,
            validator: ValidationBuilder().minLength(6).build(),
            decoration: inputDecoration.copyWith(
              hintText: 'Enter workout description',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: _workoutImageUrlController,
            validator: ValidationBuilder().url().build(),
            decoration: inputDecoration.copyWith(
              hintText: 'Enter workout image URL',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: _exerciseNameController,
            decoration: inputDecoration.copyWith(
              hintText: 'Enter exercise name',
              suffixIcon: _exerciseNameController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: _handleExerciseNameAdd,
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
            ),
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 8.0),
          const AddWorkoutInfo(),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: _handleFormSubmit,
            child: const Text('Add Workout'),
          ),
          if (_exercises.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 12.0),
                Text(
                  'Here are the exercies associated with this workout.You can either delete or reorder them',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                ExerciseList(
                  exercises: _exercises,
                  onExerciesReorder: _handleReorderExercises,
                  onExerciseDelete: _handleDeleteExercise,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class AddWorkoutInfo extends StatelessWidget {
  const AddWorkoutInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        'You can add as many exercises as you want.All exercises will be displayed on the order they are added',
        style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),
      ),
    );
  }
}
