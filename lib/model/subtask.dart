import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'subtask.g.dart';

@immutable
@JsonSerializable()
class Subtask extends Equatable {
  final bool isDone;
  final String description;

  Subtask({this.isDone = false, this.description = ""});

  @override
  List<Object> get props => [isDone, description];

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);

  Map<String, dynamic> toJson() => _$SubtaskToJson(this);
}
