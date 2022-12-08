import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/screens/common_widgets/app_text_field.dart';

import '../../../../core/constants/path_constants.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../data/workout_data.dart';
import '../../bloc/workout_details_bloc.dart';
import '../exercises_list.dart';

class WorkoutDetailsPanel extends StatefulWidget {
  final WorkoutData workout;
  final bool isReplace;

  const WorkoutDetailsPanel(
      {super.key, required this.workout, required this.isReplace});

  @override
  State<WorkoutDetailsPanel> createState() => _WorkoutDetailsPanelState();
}

class _WorkoutDetailsPanelState extends State<WorkoutDetailsPanel> {
  final TextEditingController _workoutNameEditingController =
      TextEditingController();

  @override
  void initState() {
    _workoutNameEditingController.text = widget.workout.title ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _workoutNameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _createPanelData(context);
  }

  Widget _createPanelData(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _createRectangle(),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(),
              const SizedBox(height: 20),
              _createExercisesList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createRectangle() {
    return const Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppTextField(
        title: '',
        placeholder: TextConstants.workoutNamePlaceholder,
        controller: _workoutNameEditingController,
        onTextChanged: () {
          BlocProvider.of<WorkoutDetailsBloc>(context).add(
            UpdateWorkoutEvent(
                newWorkout: WorkoutData(
                    id: widget.workout.id,
                    title: _workoutNameEditingController.text,
                    setDataList: widget.workout.setDataList),
                isReplace: widget.isReplace),
          );
        },
        errorText: TextConstants.workoutNameEmptyError,
      ),
    );
  }

  Widget _createExercisesList() {
    return BlocBuilder<WorkoutDetailsBloc, WorkoutDetailsState>(
      buildWhen: (_, currState) => currState is ReloadWorkoutDetailsState,
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExercisesList(
              exercises: widget.workout.setDataList ?? [],
              workout: widget.workout,
            ),
          ),
        );
      },
    );
  }
}
