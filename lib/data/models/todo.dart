class ToDo {
  String todoMessage;
  String isCompleted;
  int id;

  ToDo.fromJson(Map json)
      : todoMessage = json["todo"],
        isCompleted = json["isCompleted"],
        id = json["id"] as int;
}
