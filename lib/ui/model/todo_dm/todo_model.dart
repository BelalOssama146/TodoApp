 import 'package:cloud_firestore/cloud_firestore.dart';

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

   TodoModel.fromJson(Map<String,dynamic> json){
     id = json["id"];
     title = json["title"] ;
     description = json["description"];
     Timestamp timestamp = json["date"];
     date = timestamp.toDate();
     isDone = json["isDone"];
   }
   Map<String,dynamic> toJson() => {
     "id" : id,
     "title" : title,
     "description" : description,
     "date" : date,
     "isDone" : isDone,
   };


}
