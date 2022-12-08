import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/data/set_data.dart';
import 'package:workout/screens/home/bloc/home_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../data/workout_data.dart';
import '../../common_widgets/app_alert_dialog.dart';

class WorkoutCard extends StatelessWidget {
  final Color color;
  final WorkoutData workout;

  const WorkoutCard({
    super.key,
    required this.color,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (_, currState) => currState is WorkoutTappedState,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => bloc
                      .add(WorkoutTappedEvent(workout: workout, isReplace: true)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.title ?? '',
                        style: const TextStyle(
                          color: ColorConstants.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (workout.setDataList != null)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _createSetDataList()),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => appAlertDialog(context,() =>bloc.add(DelWorkoutEvent(workout: workout))),
                iconSize: 35,
                color: Colors.white,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _createSetDataList() {
    var items = workout.setDataList?.length ?? 0;
    List<SetData> lists = workout.setDataList ?? [];
    if (items > 2) {
      lists = workout.setDataList!.getRange(0, 2).toList();
      lists.add(SetData(
          id: '', title: '...', repetitions: 0, weight: 0.0, exercise: ''));
    }

    return lists
        .map((e) => Text(
              e.title ?? '',
              style: const TextStyle(
                color: ColorConstants.white,
                fontSize: 16,
                height: 1.7,
                fontWeight: FontWeight.w500,
              ),
            ))
        .toList();
  }
}
