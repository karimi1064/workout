part of 'set_details_bloc.dart';

@immutable
abstract class SetDetailsEvent {}

class BackTappedEvent extends SetDetailsEvent {}

class SetDetailsInitialEvent extends SetDetailsEvent {
  final SetData set;

  SetDetailsInitialEvent({
    required this.set,
  });
}

class SaveTappedEvent extends SetDetailsEvent {
  final SetData? set;
  final bool isReplace;

  SaveTappedEvent({
    this.set,
    this.isReplace = false,
  });
}

class UpdateSetEvent extends SetDetailsEvent {
  final SetData newSet;
  final bool isReplace;

  UpdateSetEvent({
    required this.newSet,
    this.isReplace = false,
  });
}