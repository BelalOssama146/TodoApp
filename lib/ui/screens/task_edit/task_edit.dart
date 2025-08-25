import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/extension/time_extension.dart';

import '../../model/todo_dm/todo_model.dart';
import '../../providers/list_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_colors.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({super.key});
  static const String routeName = "editTask";

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  GlobalKey<FormState> formkey = GlobalKey();
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late ListProvider listProvider;
  late ThemeProvider themeProvider;
  TodoModel? task;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    if (task == null) {
      task = ModalRoute.of(context)!.settings.arguments as TodoModel;
      titleController.text = task?.title ?? "";
      descriptionController.text = task?.description ?? "";
      selectedDate = task?.date ?? DateTime.now();
      listProvider = Provider.of(context);
    }
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.todoList,),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.13,
            color: AppColors.primary,
          ),
          Container(
            height: screenSize.height * 0.7,
            width: screenSize.width * 0.87,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: themeProvider.easyDatePicker,),
            margin: EdgeInsets.all(30),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Text(context.locale.editTask, style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium,),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      style: TextStyle(color: themeProvider.fieldText),
                      validator: (text) {
                        if (text == null || text.isEmpty == true) {
                          return context.locale.pleaseEnterTaskTitle;
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                          label: Text(titleController.text),
                          labelStyle: Theme
                              .of(context)
                              .textTheme
                              .bodySmall
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      style: TextStyle(color: themeProvider.fieldText),
                      validator: (text) {
                        if (text == null || text.isEmpty == true) {
                          return context.locale.pleaseEnterTaskDescription;
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                          label: Text(descriptionController.text),
                          labelStyle: Theme
                              .of(context)
                              .textTheme
                              .bodySmall

                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(context.locale.selectTime, style: Theme
                            .of(context)
                            .textTheme
                            .labelMedium,),
                      )),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        showMyDatePicker();
                      },
                      child:
                      Text(selectedDate.formatterDate, style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall)),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            elevation: WidgetStatePropertyAll(0),
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 60)),
                            backgroundColor: WidgetStatePropertyAll(
                                AppColors.saveColor)
                        ),
                        onPressed: () async {
                          editTask();
                        },
                        child:
                        Text(context.locale.saveChanges,
                          style: themeProvider.date,)),
                    ),
                  Spacer(flex: 6,),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
    setState(() {});
  }

  void editTask() async {
    if (formkey.currentState?.validate() == true) {
      task!.title = titleController.text;
      task!.description = descriptionController.text;
      task!.date = selectedDate;
      await TodoModel.updateTask(task!);
      listProvider.getTodoListFromFireStore();
      Navigator.pop(context);
    }
  }

}

