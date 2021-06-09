import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';

class Repository {
  final NetworkService _networkService;

  Repository(this._networkService);

  Future<List<ToDo>> fetchTodos() async {
    final todosRaw = await _networkService.fetchTodo();
    return todosRaw.map((e) => ToDo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchRequestObject = {"isCompleted": isCompleted.toString()};
    return await _networkService.patchTodo(patchRequestObject, id);
  }

  Future<ToDo> addToDo(String text) async {
    final data = {"todo": text, "isCompleted": "false"};
    final map = await _networkService.addToDo(data);

    if(map == null) return null;

    return ToDo.fromJson(map);
  }

  Future<bool> deleteTodo(int id) async{
    return await _networkService.deleteToDo(id);
  }

  Future<bool> updateToDo(ToDo toDo) async{
    final data = {"todo": toDo.todoMessage};
    return await _networkService.patchTodo(data, toDo.id);
  }
}
