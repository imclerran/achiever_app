import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
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

  // TODO: check to and from json methods to ensure proper (de)serialization
  // TODO: write unit tests

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'doneDays': doneDays,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      title: json['title'],
      doneDays: List<bool>.from(json['doneDays']),
    );
  }
}
