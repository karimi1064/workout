part of 'workout_details_bloc.dart';

abstract class WorkoutDetailsState {}

class WorkoutDetailsInitial extends WorkoutDetailsState {}

class BackTappedState extends WorkoutDetailsState {}

class ReloadWorkoutDetailsState extends WorkoutDetailsState {
  final WorkoutData workout;

  ReloadWorkoutDetailsState({
    required this.workout,
  });
}

class SetTappedState extends WorkoutDetailsState {
  final WorkoutData workout;
  final int index;
  final bool isReplace;

  SetTappedState({
    required this.workout,
    required this.index,
    required this.isReplace,
  });
}

class SaveTappedState extends WorkoutDetailsState {
  final WorkoutData workout;
  final bool isReplace;

  SaveTappedState({
    required this.workout,
    required this.isReplace,
  });
}

class UpdateWorkoutState extends WorkoutDetailsState {
  final WorkoutData newWorkout;
  final bool isReplace;

  UpdateWorkoutState({
    required this.newWorkout,
    required this.isReplace,
  });
}


