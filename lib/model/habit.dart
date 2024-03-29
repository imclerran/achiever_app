import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'habit.g.dart';

@immutable
@JsonSerializable()
class Habit extends Equatable with Comparable {
  final String id;
  final String title;
  final List<bool> doneDays;

  bool get isDoneToday {
    int weekday = DateTime.now().weekday;
    return doneDays[weekday - 1];
  }

  Habit({
    String? id,
    this.title = "",
    this.doneDays = const [false, false, false, false, false, false, false],
  }) : this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [title, doneDays, id];

  @override
  int compareTo(other) {
    if (this.isDoneToday == other.isDoneToday) {
      return this.title.compareTo(other.title);
    }
    if (this.isDoneToday && !other.isDoneToday) {
      return 1;
    }
    return -1;
  }

  // final String id;
  // final String title;
  // final List<bool> doneDays;

  factory Habit.copyWith(Habit habit,
          {String? id, String? title, List<bool>? doneDays}) =>
      Habit(
          id: id ?? habit.id,
          title: title ?? habit.title,
          doneDays: doneDays ?? habit.doneDays);

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
