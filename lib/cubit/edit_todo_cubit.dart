import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {

  final Repository repository;
  final TodosCubit todosCubit;

  EditTodoCubit({this.repository, this.todosCubit}) : super(EditTodoInitial());

  void deleteTodo(ToDo toDo) {
    repository.deleteTodo(toDo.id).then((isDeleted){
      if(isDeleted){
        todosCubit.deleteToDo(toDo);
        emit(TodoDeleteCompleted());
      }else if(!isDeleted){
        emit(TodoDeleteError("To do not deleted"));
      }
    });

  }

  void updateToDo(ToDo toDo, String text) {
    if(text.isEmpty){
      emit(TodoUpdateError("Todo is empty"));
      return;
    }

    emit(TodoUpdating());

    //create manual delay
    Timer(Duration(seconds: 3), () {
      toDo.todoMessage = text;
      repository.updateToDo(toDo);
      todosCubit.updateToDoList();
      emit(TodoUpdateCompleted());
      });

  }

}
