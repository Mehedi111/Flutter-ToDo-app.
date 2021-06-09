import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  AddTodoCubit({@required this.repository, @required this.todosCubit})
      : super(AddTodoInitial());

  void addTodo(String text) {
    if (text.isEmpty) {
      emit(AddTodoError("Todo message is empty !"));
      return;
    }

    emit(AddingTodo());

    //create manual delay
    Timer(Duration(seconds: 3), () {
      repository.addToDo(text).then((ToDo toDo) {
        if (toDo != null) {
          todosCubit.addTodo(toDo);
          emit(AddTodoCompleted());
        }
      });
    });
  }
}
