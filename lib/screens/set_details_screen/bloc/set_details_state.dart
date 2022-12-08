part of 'set_details_bloc.dart';

@immutable
abstract class SetDetailsState {}

class SetDetailsInitial extends SetDetailsState {}

class BackTappedState extends SetDetailsState {}

class ReloadSetDetailsState extends SetDetailsState {
  final SetData setData;

  ReloadSetDetailsState({
    required this.setData,
  });
}

class SaveTappedState extends SetDetailsState {
  final SetData setData;
  final bool isReplace;

  SaveTappedState({
    required this.setData,
    required this.isReplace,
  });
}

class UpdateSetState extends SetDetailsState {
  final SetData newSet;
  final bool isReplace;

  UpdateSetState({
    required this.newSet,
    required this.isReplace,
  });
}
