import 'package:workout/core/constants/path_constants.dart';
import 'package:workout/data/exercise_data.dart';

import '../../core/constants/text_constants.dart';

class DataConstants {
  // Exercise
  static final List<ExerciseData> exercises = [
    ExerciseData(
        title: TextConstants.exercise0,
        value: 0,
        icon: PathConstants.exercise0),
    ExerciseData(
        title: TextConstants.exercise1,
        value: 1,
        icon: PathConstants.exercise1),
    ExerciseData(
        title: TextConstants.exercise2,
        value: 2,
        icon: PathConstants.exercise2),
    ExerciseData(
        title: TextConstants.exercise3,
        value: 3,
        icon: PathConstants.exercise3),
    ExerciseData(
        title: TextConstants.exercise4,
        value: 4,
        icon: PathConstants.exercise4),
  ];
}
