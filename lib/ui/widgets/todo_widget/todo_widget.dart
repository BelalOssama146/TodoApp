import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/task_edit/task_edit.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

import '../../model/todo_dm/todo_model.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_colors.dart';

class TodoWidget extends StatefulWidget {
  TodoModel task;

  TodoWidget({super.key, required this.task});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late ListProvider listProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,),
      child: Slidable(
        startActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  TodoModel.deleteTask(widget.task);
                  listProvider.getTodoListFromFireStore();
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: context.locale.delete,
                spacing: 50,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ),

              ),
            ]),
        endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(
                      context, TaskEdit.routeName, arguments: widget.task);
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: context.locale.edit,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ),
              ),
            ]),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 30),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          decoration: BoxDecoration(
            color: themeProvider.easyDatePicker,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                decoration: BoxDecoration(
                  color: widget.task.isDone ? AppColors.green : AppColors
                      .primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 25,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title, style: AppStyle.listTextStyle.copyWith(
                        color: widget.task.isDone ? AppColors.green : AppColors
                            .primary
                    ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                    SizedBox(height: 8,),
                    Text(widget.task.description, style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,),
                  ],
                ),
              ),
              Spacer(),
              widget.task.isDone ? Text(context.locale.done, style: TextStyle(
                  fontSize: 20,
                  color: AppColors.green,
                  fontWeight: FontWeight.w500),)
                  : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await TodoModel.editIsDone(widget.task);
                      listProvider.getTodoListFromFireStore();
                    },
                    child: Icon(Icons.check,
                      color: AppColors.white,
                      size: 34,),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
