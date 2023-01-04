part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  TasksLoaded(this.tasks);
  get props => [tasks];
}

class TaskUpdated extends TasksLoaded {
  final Task updated;
  TaskUpdated(List<Task> tasks, this.updated) : super(tasks);
  get props => [tasks, updated];
}

class TasksNotLoaded extends TasksState {}
