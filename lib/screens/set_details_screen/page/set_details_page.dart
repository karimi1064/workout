import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/data/workout_data.dart';
import 'package:workout/screens/common_widgets/app_button.dart';

import '../../../core/constants/text_constants.dart';
import '../../../data/set_data.dart';
import '../../../service/data_service.dart';
import '../bloc/set_details_bloc.dart';
import '../widget/set_details_content.dart';

class SetDetailsPage extends StatelessWidget {
  final WorkoutData workoutData;
  final SetData set;
  final bool isReplace;

  const SetDetailsPage({
    super.key,
    required this.workoutData,
    required this.set,
    this.isReplace = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<SetDetailsBloc> _buildContext(BuildContext context) {
    final setDetailsBloc = SetDetailsBloc();
    SetData newSet = SetData(
        id: set.id,
        title: set.title,
        repetitions: set.repetitions,
        weight: set.weight,
        exercise: set.exercise);

    return BlocProvider<SetDetailsBloc>(
      create: (context) => setDetailsBloc,
      child: BlocConsumer<SetDetailsBloc, SetDetailsState>(
        buildWhen: (_, currState) => currState is SetDetailsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<SetDetailsBloc>(context);
          bloc.add(SetDetailsInitialEvent(set: set));
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: AppButton(
                title: TextConstants.save,
                onTap: () => bloc.add(SaveTappedEvent()),
              ),
            ),
            body: SetDetailsContent(setData: set, isReplace: isReplace),
          );
        },
        listenWhen: (_, currState) =>
            currState is BackTappedState ||
            currState is SaveTappedState ||
            currState is UpdateSetState,
        listener: (context, state) async {
          if (state is BackTappedState) {
            Navigator.pop(context);
          } else if (state is SaveTappedState) {
            DataService.saveSet(
                workout: workoutData,
                setData: newSet,
                isReplace: isReplace,
                oldSet: state.setData);
            Navigator.pop(context);
          } else if (state is UpdateSetState) {
            newSet = state.newSet;
          }
        },
      ),
    );
  }
}
