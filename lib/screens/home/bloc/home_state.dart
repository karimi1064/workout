part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class WorkoutTappedState extends HomeState {
  final WorkoutData workoutData;
  final bool isReplace;

  WorkoutTappedState({required this.workoutData, this.isReplace = false});
}

class ReloadWorkoutsState extends HomeState {
  final List<WorkoutData> workouts;

  ReloadWorkoutsState({
    required this.workouts,
  });
}

class DelWorkoutState extends HomeState {
  final WorkoutData workout;
  final int? index;

  DelWorkoutState({required this.workout, this.index});
}
