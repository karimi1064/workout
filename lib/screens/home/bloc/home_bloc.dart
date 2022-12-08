import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/workout_data.dart';
import '../../../service/data_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<WorkoutData> workouts = <WorkoutData>[];

  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeInitialEvent) {
        workouts = await DataService.getWorkoutsForUser();
        emit(ReloadWorkoutsState(workouts: workouts));
      } else if (event is WorkoutTappedEvent) {
        emit(WorkoutTappedState(
            workoutData: event.workout, isReplace: event.isReplace));
      } else if (event is DelWorkoutEvent) {
        emit(DelWorkoutState(workout: event.workout));
      }
    });
  }
}
