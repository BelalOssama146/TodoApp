 import 'package:cloud_firestore/cloud_firestore.dart';

import '../app_user_dm/app_user.dart';

class TodoModel {
  static const String collectionName = "todos";
  late String title;
  late String description;
  late String id;
  late DateTime date;
  late bool isDone;

  TodoModel({required this.title,
    required this.description,
    required this.id,
    required this.date,
    required this.isDone});

  TodoModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp timestamp = json["date"];
    date = timestamp.toDate();
    isDone = json["isDone"];
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "isDone": isDone,
      };

  static CollectionReference get userTodosCollection {
    return FirebaseFirestore.instance.collection(AppUser.collectionName).
    doc(AppUser.currentUser!.id).collection(TodoModel.collectionName);
  }

  static CollectionReference<TodoModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection(AppUser.collectionName)
        .doc(AppUser.currentUser!.id)
        .collection(TodoModel.collectionName)
        .withConverter<TodoModel>(
      fromFirestore: (snapshot, options) =>
          TodoModel.fromJson(snapshot.data()!),
      toFirestore: (task, options) => task.toJson(),
    );
  }

  static Future<void> editIsDone(TodoModel task) async {
    await TodoModel.getTaskCollection().doc(task.id)
        .update({"isDone": !task.isDone});
  }

  static Future<void> updateTask(TodoModel task) async {
    await TodoModel.getTaskCollection().doc(task.id).update(task.toJson());
  }

  static Future<void> deleteTask(TodoModel task) async {
    await TodoModel.getTaskCollection().doc(task.id).delete();
  }
}