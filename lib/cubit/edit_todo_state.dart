part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}
class TodoDeleteError extends EditTodoState {
  final String error;
  TodoDeleteError(this.error);
}
class TodoDeleteCompleted extends EditTodoState {}


class TodoUpdateError extends EditTodoState{
  final String error;
  TodoUpdateError(this.error);
}

class TodoUpdateCompleted extends EditTodoState{}
class TodoUpdating extends EditTodoState{}