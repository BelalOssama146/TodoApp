import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/extension/time_extension.dart';
import 'package:todo_app/ui/model/todo_dm/todo_model.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';


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
  late ListProvider listProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Container(
      color: themeProvider.easyDatePicker,
      height: MediaQuery.of(context).size.height *0.5,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.locale.addNewTask, textAlign: TextAlign.center, style: Theme
              .of(context)
              .textTheme
              .labelMedium,),
           SizedBox(height: 10,),
           TextField(
             controller: titleController,
            decoration: InputDecoration(
              hintText: context.locale.enterTaskTitle,
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,
            ),
          ),
           SizedBox(height: 10,),
           TextField(
             controller: descriptionController,
            decoration: InputDecoration(
              hintText: context.locale.enterTaskDescription,
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,
            ),
          ),
           SizedBox(height: 10,),
          Text(context.locale.selectDate, style: Theme
              .of(context)
              .textTheme
              .labelMedium,),
           SizedBox(height: 10,),
          InkWell(
              onTap: (){
                showMyDatePicker();
              },
              child: Text(
                selectedDate.formatterDate, textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,)),
          const Spacer(),
          ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onPressed: (){
                addTodoListToFireStore();
              },
              child: Text(context.locale.add, style: themeProvider.date,)),
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

  void addTodoListToFireStore() async {
    CollectionReference todosCollection = TodoModel.userTodosCollection;
    DocumentReference doc = todosCollection.doc();
    TodoModel todoModel = TodoModel(
        title: titleController.text,
        description: descriptionController.text,
        id: doc.id,
        date: selectedDate,
        isDone: false);
    await doc.set(todoModel.toJson());
    listProvider.getTodoListFromFireStore();
        Navigator.pop(context);

  }


}
//       .then((_) {
//   ///this callback is called when future is completed
// },).
// onError((error, stackTrace) {
//   ///this callback is called when an error throws an exception
// },)
// .timeout(Duration(milliseconds: 500),
//       onTimeout:(){
//     ///this callback is called after duration you have in first argument

//       } );
