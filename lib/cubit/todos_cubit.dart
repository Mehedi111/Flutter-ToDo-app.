
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todos_state.dart';
import 'package:todo_app/data/repository.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository _repository;

  TodosCubit(this._repository) : super(TodosInitial());

  void fetchTodos() {

    Timer(Duration(seconds: 3), () {
      _repository.fetchTodos().then((todoList) {
        emit(TodosLoaded(todoList));
      });
    });
  }
}
