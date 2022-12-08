part of 'workout_details_bloc.dart';

abstract class WorkoutDetailsEvent {}

class BackTappedEvent extends WorkoutDetailsEvent {}

class WorkoutDetailsInitialEvent extends WorkoutDetailsEvent {
  final WorkoutData workout;

  WorkoutDetailsInitialEvent({
    required this.workout,
  });
}

class SetTappedEvent extends WorkoutDetailsEvent {
  final WorkoutData? workout;
  final int? index;
  final bool isReplace;

  SetTappedEvent({
    this.workout,
    this.index,
    this.isReplace = false,
  });
}

class SaveTappedEvent extends WorkoutDetailsEvent {
  final WorkoutData? workout;
  final bool isReplace;

  SaveTappedEvent({
    this.workout,
    this.isReplace = false,
  });
}

class UpdateWorkoutEvent extends WorkoutDetailsEvent {
  final WorkoutData newWorkout;
  final bool isReplace;

  UpdateWorkoutEvent({
    required this.newWorkout,
    this.isReplace = false,
  });
}
