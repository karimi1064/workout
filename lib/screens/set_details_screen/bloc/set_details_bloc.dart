import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/data/set_data.dart';
import 'package:meta/meta.dart';

part 'set_details_event.dart';

part 'set_details_state.dart';

class SetDetailsBloc extends Bloc<SetDetailsEvent, SetDetailsState> {
  late SetData setData;
  late SetData newSet;

  SetDetailsBloc() : super(SetDetailsInitial()) {
    on<SetDetailsEvent>((event, emit) {
      if (event is SetDetailsInitialEvent) {
        setData = event.set;
        emit(ReloadSetDetailsState(setData: setData));
      } else if (event is BackTappedEvent) {
        emit(BackTappedState());
      } else if (event is SaveTappedEvent) {
        emit(SaveTappedState(
          setData: event.set ?? setData,
          isReplace: event.isReplace,
        ));
      } else if (event is UpdateSetEvent) {
        newSet = event.newSet;
        emit(UpdateSetState(
          newSet: event.newSet,
          isReplace: event.isReplace,
        ));
      }
    });
  }
}
