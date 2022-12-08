import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/workout_data.dart';

part 'workout_details_event.dart';

part 'workout_details_state.dart';

class WorkoutDetailsBloc
    extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  WorkoutDetailsBloc() : super(WorkoutDetailsInitial()) {
    late WorkoutData workout;

    on<WorkoutDetailsEvent>((event, emit) {
      if (event is WorkoutDetailsInitialEvent) {
        workout = event.workout;
        emit(ReloadWorkoutDetailsState(workout: workout));
      } else if (event is BackTappedEvent) {
        emit(BackTappedState());
      } else if (event is SetTappedEvent) {
        emit(SetTappedState(
          workout: event.workout ?? workout,
          index: event.index ?? 0,
          isReplace: event.isReplace,
        ));
      } else if (event is SaveTappedEvent) {
        emit(SaveTappedState(
          workout: event.workout ?? workout,
          isReplace: event.isReplace,
        ));
      } else if (event is UpdateWorkoutEvent) {
        emit(UpdateWorkoutState(
          newWorkout: event.newWorkout,
          isReplace: event.isReplace,
        ));
      }
    });
  }
}
