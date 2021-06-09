import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchTodo() async {
    try {
      final response = await get(Uri.parse("$baseUrl/todos"));
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchRequestObject, int id) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"), body: patchRequestObject);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> addToDo(Map<String, String> data) async {
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: data);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool>deleteToDo(int id) async {
    try{
      await delete(Uri.parse(baseUrl + "/todos/$id"));
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}
