import 'dart:convert';

class SetData {
  String? id;
  String? title;
  int? repetitions;
  double? weight;
  String? exercise;

  SetData({
    required this.id,
    required this.title,
    required this.repetitions,
    required this.weight,
    required this.exercise,
  });

  SetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    repetitions = json['minutes'];
    weight = json['weight'];
    exercise = json['exercise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['minutes'] = repetitions;
    data['weight'] = weight;
    data['exercise'] = exercise;
    return data;
  }

  String toJsonString() {
    final str = json.encode(toJson());
    return str;
  }
}