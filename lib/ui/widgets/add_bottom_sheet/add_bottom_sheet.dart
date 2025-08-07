import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/extension/time_extension.dart';
import 'package:todo_app/ui/model/todo_dm/todo_model.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});
  @override

  State<AddBottomSheet> createState() => _AddBottomSheetState();
  static void show(BuildContext context){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder:(context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: AddBottomSheet(),
    ));
  }
}
class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: MediaQuery.of(context).size.height *0.5,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Add new task ",textAlign: TextAlign.center,style: AppStyle.bottomSheetTitle,),
           SizedBox(height: 10,),
           TextField(
             controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter task title",
              hintStyle: AppStyle.normalGreyTextStyle.copyWith(fontSize: 16),
            ),
          ),
           SizedBox(height: 10,),
           TextField(
             controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Enter task description",
              hintStyle: AppStyle.normalGreyTextStyle.copyWith(fontSize: 16),
            ),
          ),
           SizedBox(height: 10,),
          const Text("Select date",style: AppStyle.bottomSheetTitle,),
           SizedBox(height: 10,),
          InkWell(
              onTap: (){
                showMyDatePicker();
              },
              child: Text(selectedDate.formatterDate,textAlign: TextAlign.center,style: AppStyle.normalGreyTextStyle,)),
          const Spacer(),
          ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onPressed: (){
            addTodoListFromFireStore();
              },
              child: Text("Add",style: TextStyle(color: AppColors.white),))
        ],
      ),
    );
  }

  void showMyDatePicker() async{
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))??selectedDate;
        setState(() {});
  }

  void addTodoListFromFireStore() {
    CollectionReference todosCollection= FirebaseFirestore.instance.collection(TodoModel.collectionName);
    DocumentReference doc = todosCollection.doc();
    TodoModel todoModel = TodoModel(
        title: titleController.text,
        description: descriptionController.text,
        id: doc.id,
        date: selectedDate,
        isDone: false);
        doc.set(todoModel.toJson()).then((_) {
        ///this callback is called when future is completed
      },).
      onError((error, stackTrace) {
        ///this callback is called when an error throws an exception
      },).
      timeout(Duration(milliseconds: 500),
          onTimeout:(){
        ///this callback is called after duration you have in first argument
        Navigator.pop(context);
          } );
  }
}
