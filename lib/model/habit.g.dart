// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: json['id'] as String?,
      title: json['title'] as String? ?? "",
      doneDays: (json['doneDays'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          const [false, false, false, false, false, false, false],
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'doneDays': instance.doneDays,
    };
