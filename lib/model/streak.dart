import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Streak extends Equatable with Comparable {
  final String id;
  final String title;
  final String units;
  final int streakLength;
  final DateTime? lastCompleted;

  Streak({
    String? id,
    this.title = "",
    this.units = "Days",
    this.streakLength = 0,
    this.lastCompleted,
  }) : this.id = id ?? Uuid().v4();

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
