import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/contants/string.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/presentation/screens/AddTodosScreen.dart';
import 'package:todo_app/presentation/screens/EditTodosScreen.dart';
import 'package:todo_app/presentation/screens/TodosHomeScreen.dart';

class AppRouter {
  Repository repository;
  TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(NetworkService());
    todosCubit = TodosCubit(repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.HomeRoute:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                    value: todosCubit,
                    child: Todos_home()));
      case Constants.AddToDoRoute:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                    create: (context) => AddTodoCubit(
                      repository: repository,
                      todosCubit: todosCubit
                    ),
                    child: AddTodosScreen())
        );
      case Constants.EditToDoRoute:
        final todo = settings.arguments as ToDo;
        return MaterialPageRoute(builder: (_) => EditTodosScreen(todo));

      default:
        return null;
    }
  }
}
