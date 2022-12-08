import 'package:flutter/material.dart';
import 'package:workout/data/workout_data.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/text_constants.dart';
import 'home_exercises_card.dart';

class HomeContent extends StatelessWidget {
  final List<WorkoutData> workouts;

  const HomeContent({Key? key, required this.workouts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: _createHomeBody(context, workouts),
    );
  }

  Widget _createHomeBody(BuildContext context, List<WorkoutData> workouts) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createHeader(),
          const SizedBox(height: 15),
          _createWorkoutsList(context, workouts),
        ],
      ),
    );
  }
}

Widget _createWorkoutsList(BuildContext context, List<WorkoutData> workouts) {
  return Expanded(
    child: ListView.separated(
      itemCount: workouts.length,
      itemBuilder: (_, index) => WorkoutCard(
        color: (index % 2 == 0)
            ? ColorConstants.cardioColor
            : ColorConstants.armsColor,
        workout: workouts[index],
      ),
      separatorBuilder: (_, index) => const SizedBox(height: 15),
    ),
  );
}

Widget _createHeader() {
  return const Text(
    TextConstants.discoverWorkouts,
    style: TextStyle(
      color: ColorConstants.textBlack,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}
