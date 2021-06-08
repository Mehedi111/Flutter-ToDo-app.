import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/contants/string.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/presentation/screens/AddTodosScreen.dart';
import 'package:todo_app/presentation/screens/EditTodosScreen.dart';
import 'package:todo_app/presentation/screens/TodosHomeScreen.dart';

class AppRouter {
  Repository repository;

  AppRouter(){
    repository = Repository(NetworkService());
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.HomeRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => TodosCubit(repository),
                child: Todos_home()));
      case Constants.EditToDoRoute:
        return MaterialPageRoute(builder: (_) => EditTodosScreen());
      case Constants.AddToDoRoute:
        return MaterialPageRoute(builder: (_) => AddTodosScreen());

      default:
        return null;
    }
  }
}
