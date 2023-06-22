// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subtask _$SubtaskFromJson(Map<String, dynamic> json) => Subtask(
      isDone: json['isDone'] as bool? ?? false,
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$SubtaskToJson(Subtask instance) => <String, dynamic>{
      'isDone': instance.isDone,
      'description': instance.description,
    };
