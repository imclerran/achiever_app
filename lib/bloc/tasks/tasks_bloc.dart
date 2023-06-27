import 'dart:convert';

import 'package:achiever_app/data/data.dart';
import 'package:achiever_app/model/task.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskDone>(_onToggleTaskDone);
  }

  _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) {
    /// Manual typecasting to resolve strange runtime type error:
    /// type '_Map<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'
    /// this manual typecasting is not necessary for the identical code in _onLoadHabits()
    ///
    /// ```dart
    /// Map<String, dynamic> habitsJson = HydratedBloc.storage.read('HabitsBloc');
    /// HabitsLoaded habitsState = fromJson(habitsJson) as HabitsLoaded;
    /// emit(habitsState);
    /// ```
    Map<dynamic, dynamic> tasksPreJson = HydratedBloc.storage.read('TasksBloc');
    Map<String, dynamic> tasksJson = tasksPreJson.map(
      (key, value) => MapEntry(key.toString(), value),
    );
    TasksLoaded habitsState = fromJson(tasksJson) as TasksLoaded;
    emit(habitsState);
  }

  _onAddTask(AddTask event, Emitter<TasksState> emit) {
    List<Task> updatedList = List.from(state.tasks)..add(event.task);
    emit(TasksLoaded(updatedList));
  }

  _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final List<Task> updatedList = state.tasks
        .map((task) => task.id == event.task.id ? event.task : task)
        .toList();
    emit(TasksLoaded(updatedList));
  }

  _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final List<Task> updatedList =
        state.tasks.where((task) => task.id != event.task.id).toList();
    emit(TasksLoaded(updatedList));
  }

  _onToggleTaskDone(ToggleTaskDone event, Emitter<TasksState> emit) {
    final List<Task> updatedList = state.tasks.map((task) {
      if (task.id == event.task.id) {
        bool isDone = !task.isDone;
        Task updatedTask = Task(
          id: task.id,
          isDone: isDone,
          dateCompleted: isDone ? DateTime.now() : null,
          dueDate: task.dueDate,
          title: task.title,
          description: task.description,
          priority: task.priority,
          subtasks: task.subtasks,
        );
        return updatedTask;
      }
      return task;
    }).toList();
    emit(TasksLoaded(updatedList));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    List<dynamic> tasksJson = jsonDecode(json['tasks']);
    List<Task> tasks = List.empty(growable: true);
    for (Map<String, dynamic> taskJson in tasksJson) {
      tasks.add(Task.fromJson(taskJson));
    }
    return TasksLoaded(tasks);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    if (state is TasksLoaded) {
      String tasksJson = jsonEncode(state.tasks);
      return {'tasks': tasksJson};
    } else if (state is TasksInitial) {
      String tasksJson = jsonEncode(state.tasks);
      return {'tasks': tasksJson};
    } else {
      return {'tasks': '[]'};
    }
  }
}
