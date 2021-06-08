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
              children: todos.map((e) => singleToDoWidget(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget singleToDoWidget(ToDo todo, context){
    return Dismissible(
      key: Key("${todo.id}"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[200])
          )
        ),
        child: Row(
          children: [
            Text(todo.todoMessage)
          ],
        ),
      ),
    );
  }

}
