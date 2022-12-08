import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/core/constants/text_constants.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/path_constants.dart';
import '../../../data/set_data.dart';
import '../../../data/workout_data.dart';
import '../bloc/workout_details_bloc.dart';

class ExerciseItem extends StatelessWidget {
  final WorkoutData workout;
  final SetData currentExercise;
  final int index;

  const ExerciseItem({
    super.key,
    required this.currentExercise,
    required this.workout,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutDetailsBloc>(context);
    return BlocBuilder<WorkoutDetailsBloc, WorkoutDetailsState>(
      buildWhen: (_, currState) => currState is SetTappedState,
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            bloc.add(
              SetTappedEvent(
                workout: workout,
                index: index,
                isReplace: true
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.textBlack.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1,
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: _createExerciseTextInfo(),
                ),
                const SizedBox(width: 10),
                _createRightArrow(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createExerciseTextInfo() {
    final repetitions = "${TextConstants.repetitions}: ${currentExercise.repetitions}";
    final weight = "${TextConstants.weight}: ${currentExercise.weight}";
    final exercise = "${TextConstants.exercise}: ${currentExercise.exercise}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentExercise.title ?? "",
          style: const TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          exercise,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          repetitions,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          weight,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _createRightArrow() {
    return const RotatedBox(
      quarterTurns: 2,
      child: Image(
        image: AssetImage(PathConstants.back),
      ),
    );
  }
}
