import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/contants/string.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/cubit/todos_state.dart';
import 'package:todo_app/data/models/todo.dart';

class Todos_home extends StatelessWidget {
  const Todos_home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Constants.AddToDoRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (!(state is TodosLoaded)) {
            return Center(child: CircularProgressIndicator(strokeWidth: 5));
          }

          final todos = (state as TodosLoaded).todos;

          return SingleChildScrollView(
            child: Column(
              children:
                  todos.map((e) => _singleToDoWidget(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _singleToDoWidget(ToDo todo, context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Constants.EditToDoRoute, arguments: todo);
      },
      child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoTile(todo, context),
        background: Container(color: Colors.deepPurple),
        confirmDismiss: (_) async{
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
      ),
    );
  }

  Widget _todoTile(ToDo todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(todo.todoMessage), _isCompleteView(todo)],
      ),
    );
  }

  Widget _isCompleteView(ToDo toDo) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              width: 4, color: toDo.isCompleted ? Colors.green : Colors.red)),
    );
  }
}
