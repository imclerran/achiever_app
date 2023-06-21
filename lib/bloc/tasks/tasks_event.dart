part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TasksEvent {}

class AddTask extends TasksEvent {
  final Task task;
  AddTask(this.task);
  get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;
  UpdateTask(this.task);
  get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  DeleteTask(this.task);
  get props => [task];
}

class ToggleTaskDone extends TasksEvent {
  final Task task;
  ToggleTaskDone(this.task);
  get props => [task];
}
