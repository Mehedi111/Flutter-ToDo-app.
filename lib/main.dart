import 'package:flutter/material.dart';
import 'package:todo_app/presentation/router.dart';
import 'package:todo_app/presentation/screens/TodosHomeScreen.dart';

void main() => runApp(ToDoApp(
  router: AppRouter(),
));

class ToDoApp extends StatelessWidget {
  final AppRouter router;

  const ToDoApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
