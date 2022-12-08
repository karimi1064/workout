import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/path_constants.dart';
import '../../../data/workout_data.dart';
import '../bloc/workout_details_bloc.dart';

class WorkoutDetailsBody extends StatelessWidget {
  final WorkoutData workout;

  const WorkoutDetailsBody({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createImage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
      child: const Image(
        image: AssetImage(PathConstants.exercise),
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget _createBackButton(BuildContext context) {
  final bloc = BlocProvider.of<WorkoutDetailsBloc>(context);
  return Positioned(
    left: 20,
    top: 14,
    child: SafeArea(
      child: BlocBuilder<WorkoutDetailsBloc, WorkoutDetailsState>(
        builder: (context, state) {
          return GestureDetector(
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage(PathConstants.back),
              ),
            ),
            onTap: () {
              bloc.add(BackTappedEvent());
            },
          );
        },
      ),
    ),
  );
}
