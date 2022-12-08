import 'dart:convert';

import 'package:workout/data/set_data.dart';
import 'package:workout/service/workout_storage_service.dart';

import '../core/constants/constants.dart';
import '../data/workout_data.dart';

class DataService {
  static Future<List<WorkoutData>> getWorkoutsForUser() async {
    final workoutsStr = await WorkoutStorageService.readSecureData('Workouts');
    if (workoutsStr == null) return [];
    final decoded = (json.decode(workoutsStr) as List?) ?? [];
    final workouts = decoded.map((e) {
      final decodedE = json.decode(e) as Map<String, dynamic>?;
      return WorkoutData.fromJson(decodedE!);
    }).toList();
    Constants.workouts = workouts;
    return workouts;
  }

  static Future<void> saveWorkout(
      {required WorkoutData workout,
      WorkoutData? oldWorkout,
      bool isReplace = false}) async {
    final allWorkouts = await getWorkoutsForUser();
    var index = -1;

    if (isReplace) {
      index = allWorkouts
          .indexWhere((element) => element.title == oldWorkout?.title);
      allWorkouts[index] = workout;
    } else {
      index =
          allWorkouts.indexWhere((element) => element.title == workout.title);
      if (index == -1) {
        allWorkouts.add(workout);
      }
    }

    Constants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    await WorkoutStorageService.writeSecureData(
      'Workouts',
      encoded,
    );
  }

  static Future<void> saveSet(
      {required WorkoutData workout,
      required SetData setData,
      SetData? oldSet,
      bool isReplace = false}) async {
    final allSet = workout.setDataList ?? [];
    var index = -1;

    if (isReplace) {
      index = allSet
          .indexWhere((element) => element.title == (oldSet?.title ?? ''));
      if (index != -1) {
        allSet[index] = setData;
      }
    } else {
      index = allSet.indexWhere((element) => element.title == workout.title);
      if (index == -1) {
        allSet.add(setData);
      }
    }

    final allWorkouts = await getWorkoutsForUser();
    int indexOfWorkout = allWorkouts.indexOf(workout);
    if (indexOfWorkout != -1) {
      workout.setDataList = allSet;
      allWorkouts[indexOfWorkout] = workout;
    }
    Constants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    await WorkoutStorageService.writeSecureData(
      'Workouts',
      encoded,
    );
  }

  static Future<void> delWorkout({required WorkoutData workout}) async {
    final allWorkouts = await getWorkoutsForUser();
    var itemIndexForDel =
        allWorkouts.indexWhere((element) => element.title == workout.title);
    if (itemIndexForDel != -1) {
      allWorkouts.removeAt(itemIndexForDel);
    }

    Constants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    await WorkoutStorageService.writeSecureData(
      'Workouts',
      encoded,
    );
  }
}
