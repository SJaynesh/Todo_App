class TodoModel {
  int id;
  String title;

  TodoModel({
    required this.id,
    required this.title,
  });

  factory TodoModel.fromMap({required Map<String, dynamic> data}) => TodoModel(
        id: data['id'],
        title: data['title'],
      );
}
