import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/core/constants/color_constants.dart';
import 'package:workout/data/set_data.dart';

import '../../../data/workout_data.dart';
import '../../../service/data_service.dart';
import '../../set_details_screen/page/set_details_page.dart';
import '../bloc/workout_details_bloc.dart';
import '../widget/workout_details_content.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final WorkoutData workout;
  final bool isReplace;

  const WorkoutDetailsPage({
    super.key,
    required this.workout,
    this.isReplace = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<WorkoutDetailsBloc> _buildContext(BuildContext context) {
    final workoutDetailsBloc = WorkoutDetailsBloc();
    WorkoutData newWorkout = WorkoutData(
        id: workout.id, title: workout.title, setDataList: workout.setDataList);

    return BlocProvider<WorkoutDetailsBloc>(
      create: (context) => workoutDetailsBloc,
      child: BlocConsumer<WorkoutDetailsBloc, WorkoutDetailsState>(
        buildWhen: (_, currState) => currState is WorkoutDetailsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<WorkoutDetailsBloc>(context);
          bloc.add(WorkoutDetailsInitialEvent(workout: workout));
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      heroTag: null,
                      backgroundColor: ColorConstants.primaryColor,
                      child: const Icon(Icons.save),
                      onPressed: () => bloc.add(SaveTappedEvent(
                          workout: workout, isReplace: isReplace))),
                  FloatingActionButton(
                    heroTag: null,
                    backgroundColor: ColorConstants.primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () => bloc.add(
                        SetTappedEvent(workout: workout, isReplace: false)),
                  ),
                ],
              ),
            ),
            body: WorkoutDetailsContent(workout: workout, isReplace: isReplace),
          );
        },
        listenWhen: (_, currState) =>
            currState is BackTappedState ||
            currState is SetTappedState ||
            currState is SaveTappedState ||
            currState is UpdateWorkoutState,
        listener: (context, state) async {
          if (state is BackTappedState) {
            Navigator.pop(context);
          } else if (state is SetTappedState) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WorkoutDetailsBloc>(context),
                  child: SetDetailsPage(
                    workoutData: state.workout,
                    set: state.isReplace
                        ? state.workout.setDataList![state.index]
                        : SetData(
                            id: '',
                            title: '',
                            repetitions: 0,
                            weight: 0.0,
                            exercise: ''),
                    isReplace: state.isReplace,
                  ),
                ),
              ),
            );
            workoutDetailsBloc
                .add(WorkoutDetailsInitialEvent(workout: workout));
          } else if (state is SaveTappedState) {
            DataService.saveWorkout(
                workout: newWorkout, oldWorkout: workout, isReplace: isReplace);
            Navigator.pop(context);
          } else if (state is UpdateWorkoutState) {
            newWorkout = state.newWorkout;
          }
        },
      ),
    );
  }
}
