
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';

class Repository{
  final NetworkService _networkService;

  Repository(this._networkService);

  Future<List<ToDo>> fetchTodos() async{
    final todosRaw = await _networkService.fetchTodo();
    return todosRaw.map((e) => ToDo.fromJson(e)).toList();
  }

}