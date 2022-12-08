import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/constants/color_constants.dart';
import '../../../data/workout_data.dart';
import 'panel/workout_details_panel.dart';
import 'workout_details_body.dart';

class WorkoutDetailsContent extends StatelessWidget {
  final WorkoutData workout;
  final bool isReplace;

  const WorkoutDetailsContent({super.key, required this.workout, required this.isReplace});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      panel: WorkoutDetailsPanel(workout: workout,isReplace: isReplace,),
      body: WorkoutDetailsBody(workout: workout),
      minHeight: MediaQuery.of(context).size.height * 0.65,
      maxHeight: MediaQuery.of(context).size.height * 0.87,
      isDraggable: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }
}