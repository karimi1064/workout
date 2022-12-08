part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class WorkoutTappedEvent extends HomeEvent {
  final WorkoutData workout;
  final int? index;
  final bool isReplace;

  WorkoutTappedEvent({
    required this.workout,
    this.index,
    this.isReplace = false,
  });
}

class DelWorkoutEvent extends HomeEvent {
  final WorkoutData workout;
  final int? index;

  DelWorkoutEvent({
    required this.workout,
    this.index,
  });
}