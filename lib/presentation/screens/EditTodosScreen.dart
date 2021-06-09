import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodosScreen extends StatelessWidget {
  final ToDo toDo;

  final TextEditingController _controller = TextEditingController();

  EditTodosScreen(this.toDo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = toDo.todoMessage;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit todo"),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter todo message"),
          ),
          SizedBox(height: 16),
          InkWell(onTap: () {}, child: _editToDoButton(context))
        ],
      ),
    );
  }

  Widget _editToDoButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text("Update todo", style: TextStyle(color: Colors.white))),
    );
  }
}
