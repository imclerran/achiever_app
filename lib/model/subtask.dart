import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Subtask extends Equatable {
  final bool isDone;
  final String description;

  Subtask({this.isDone = false, this.description = ""});

  @override
  List<Object> get props => [isDone, description];
}
