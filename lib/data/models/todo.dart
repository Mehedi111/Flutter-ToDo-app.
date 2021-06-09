class ToDo {
  String todoMessage;
  bool isCompleted;
  int id;

  ToDo.fromJson(Map json)
      : todoMessage = json["todo"],
        isCompleted = json["isCompleted"] == "true",
        id = json["id"] as int;
}
