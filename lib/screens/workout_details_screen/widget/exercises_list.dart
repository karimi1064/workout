import 'package:flutter/material.dart';
import 'package:workout/screens/workout_details_screen/widget/exercise_item.dart';

import '../../../data/set_data.dart';
import '../../../data/workout_data.dart';

class ExercisesList extends StatelessWidget {
  final WorkoutData workout;
  final List<SetData> exercises;

  const ExercisesList(
      {super.key, required this.exercises, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseItem(
          currentExercise: exercises[index],
          workout: workout,
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}
