import 'dart:convert';

import 'package:workout/data/set_data.dart';


class WorkoutData {
  String? id;
  String? title;
  List<SetData>? setDataList;

  WorkoutData({
    required this.id,
    required this.title,
    required this.setDataList,
  });

  WorkoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['setDataList'] != null) {
      List<SetData> exercises = [];
      json['setDataList'].forEach((v) {
        exercises.add(SetData.fromJson(v));
      });
      setDataList = exercises;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (setDataList != null) {
      data['setDataList'] =
          setDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJsonString() {
    final str = json.encode(toJson());
    return str;
  }
}