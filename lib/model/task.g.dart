// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      isDone: json['isDone'] as bool? ?? false,
      dateCompleted: json['dateCompleted'] == null
          ? null
          : DateTime.parse(json['dateCompleted'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
          TaskPriority.none,
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'isDone': instance.isDone,
      'dateCompleted': instance.dateCompleted?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'subtasks': instance.subtasks,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.high: 'high',
  TaskPriority.medium: 'medium',
  TaskPriority.low: 'low',
  TaskPriority.none: 'none',
};
