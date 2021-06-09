import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todos_state.dart';
import 'package:todo_app/data/models/todo.dart';
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

  void changeCompletion(ToDo todo) {
    _repository.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateToDoList();
      }
    });
  }

  void updateToDoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(currentState.todos));
    }
  }

  void addTodo(ToDo toDo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      var todos = currentState.todos;
      todos.add(toDo);
      emit(TodosLoaded(todos));
    }
  }

  void deleteToDo(ToDo toDo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      var todos = currentState.todos.where((element) => element.id !=  toDo.id).toList();
      emit(TodosLoaded(todos));
    }
  }
}
