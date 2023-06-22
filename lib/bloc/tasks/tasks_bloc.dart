import 'package:achiever_app/model/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskDone>(_onToggleTaskDone);
  }

  // TODO: write onEvent functions

  _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) {}
  _onAddTask(AddTask event, Emitter<TasksState> emit) {}
  _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {}
  _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {}
  _onToggleTaskDone(ToggleTaskDone event, Emitter<TasksState> emit) {}
}
