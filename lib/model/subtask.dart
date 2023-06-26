import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'subtask.g.dart';

@immutable
@JsonSerializable()
class Subtask extends Equatable {
  final String id;
  final bool isDone;
  final String description;

  Subtask({String? id, this.isDone = false, this.description = ""})
      : this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [isDone, description];

  factory Subtask.copyWith(Subtask subtask,
          {String? id, bool? isDone, String? description}) =>
      Subtask(
          id: id ?? subtask.id,
          isDone: isDone ?? subtask.isDone,
          description: description ?? subtask.description);

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);

  Map<String, dynamic> toJson() => _$SubtaskToJson(this);
}
