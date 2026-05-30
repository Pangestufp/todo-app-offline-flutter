class Todo {
  String id;
  String title;
  String description;
  String status;
  String createdDate;

  Todo({//required artinya tidak boleh null saat membuat objek ini dengan constructor
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });

  //map json ke object
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    createdDate: json["createdDate"],
  );

  //map object ke json
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "createdDate": createdDate,
  };
}