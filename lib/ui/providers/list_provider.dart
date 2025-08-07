import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/todo_dm/todo_model.dart';

class ListProvider extends ChangeNotifier {
  DateTime selectedCalenderTime = DateTime.now();
  List<TodoModel> todosList = [];
  void getTodoListFromFireStore() async {
    CollectionReference todosCollection = FirebaseFirestore.instance.collection(TodoModel.collectionName);
    QuerySnapshot querySnapshot = await todosCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String,dynamic>;
      return TodoModel.fromJson(json);
    }).toList();
    todosList = todosList.where((todo) =>
    todo.date.year == selectedCalenderTime.year &&
        todo.date.month == selectedCalenderTime.month &&
        todo.date.day == selectedCalenderTime.day)
        .toList();

    todosList.sort((todo1,todo2){
       return todo1.date.compareTo(todo2.date);
    });
    notifyListeners();
  }
}