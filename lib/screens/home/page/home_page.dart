import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../data/workout_data.dart';
import '../../../service/data_service.dart';
import '../../workout_details_screen/page/workout_details_page.dart';
import '../bloc/home_bloc.dart';
import '../widget/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeBloc();
    return BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (_, currState) =>
            (currState is HomeInitialState || currState is ReloadWorkoutsState),
        builder: (context, state) {
          final bloc = BlocProvider.of<HomeBloc>(context);
          bloc.add(HomeInitialEvent());
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              backgroundColor: ColorConstants.primaryColor,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () => bloc.add(WorkoutTappedEvent(
                  workout: WorkoutData(id: '', title: '', setDataList: []),
                  isReplace: false)),
            ),
            body: HomeContent(workouts: bloc.workouts),
          );
        },
        listenWhen: (_, currState) =>
            (currState is WorkoutTappedState || currState is DelWorkoutState),
        listener: (context, state) async {
          var homeBloc = BlocProvider.of<HomeBloc>(context);
          if (state is WorkoutTappedState) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<HomeBloc>(context),
                  child: WorkoutDetailsPage(
                    workout: state.workoutData,
                    isReplace: state.isReplace,
                  ),
                ),
              ),
            );
            homeBloc.add(HomeInitialEvent());
          } else if (state is DelWorkoutState) {
            DataService.delWorkout(workout: state.workout);
            homeBloc.add(HomeInitialEvent());
          }
        },
      ),
    );
  }
}
