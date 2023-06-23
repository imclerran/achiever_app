part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {
  final List<Task> tasks;
  TasksInitial() : tasks = data.tasks;
  get props => [tasks];
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  TasksLoaded(this.tasks);
  get props => [tasks];
}
