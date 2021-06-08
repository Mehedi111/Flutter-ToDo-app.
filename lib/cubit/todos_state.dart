
import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';

@immutable
abstract class TodosState {}

class TodosInitial extends TodosState {}
class TodosLoaded extends TodosState {
  final List<ToDo> todos;

  TodosLoaded(this.todos);
}
