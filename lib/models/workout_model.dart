// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Workout {
  final String id;
  final String title;
  final List<Exercise> exercises;
  final String description;
  final String imageUrl;

  const Workout({
    required this.id,
    required this.title,
    required this.exercises,
    required this.description,
    required this.imageUrl,
  });

  Workout copyWith({
    String? id,
    String? title,
    List<Exercise>? exercises,
    String? description,
    String? imageUrl,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      exercises: exercises ?? this.exercises,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'exercises': exercises.map((x) => x.toMap()).toList(),
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as String,
      title: map['title'] as String,
      exercises: List<Exercise>.from(
        (map['exercises'] as List<dynamic>).map<Exercise>(
          (x) => Exercise.fromMap(x as Map<String, dynamic>),
        ),
      ),
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Workout(id: $id, title: $title, exercises: $exercises, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant Workout other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.exercises, exercises) &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        exercises.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}

class Exercise {
  final String id;
  final String name;

  Exercise({
    required this.id,
    required this.name,
  });

  Exercise copyWith({
    String? id,
    String? name,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Exercise(id: $id, name: $name)';

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
