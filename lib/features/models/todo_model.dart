import 'package:hive_flutter/hive_flutter.dart';

part "todo_model.g.dart";

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool status;

  TodoModel({required this.id, required this.status, required this.title});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }

  TodoModel copyWith({
    int? id,
    String? title,
    bool? status,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is TodoModel &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => id.hashCode;
}
