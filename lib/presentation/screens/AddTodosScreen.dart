import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodosScreen extends StatelessWidget {
  AddTodosScreen({Key key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add ToDo"),
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if(state is AddTodoCompleted){
              Navigator.pop(context);
            }else if(state is AddTodoError){
              Toast.show(state.error, context, duration: 3, backgroundColor: Colors.red,
              gravity: Toast.CENTER);
            }
          },
          child: Container(
            margin: EdgeInsets.all(16),
            child: _body(context),
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter todo message"),
        ),
        SizedBox(height: 16),
        InkWell(onTap: () {
          BlocProvider.of<AddTodoCubit>(context).addTodo(_controller.text);
        }, child: _addToDoButton(context))
      ],
    );
  }

  Widget _addToDoButton(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 48,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) {
              return CircularProgressIndicator();
            }

            return Text("Add todo", style: TextStyle(color: Colors.white));
          },
        ),
      ),
    );
  }
}
