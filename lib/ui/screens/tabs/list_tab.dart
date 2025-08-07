import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/time_extension.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import 'package:todo_app/ui/widgets/todo_widget/todo_widget.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      ///this block is called after build and called only once time
      listProvider.getTodoListFromFireStore();
    });

  }
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCalender(),
        Expanded(flex: 85,
          child: ListView.builder(
            itemCount: listProvider.todosList.length,
            itemBuilder: (context, index) {
              return TodoWidget(item: listProvider.todosList[index],);
            },),
        ),
      ],
    );
  }
  buildCalender() {
    return Expanded(
      flex: 75,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(color: AppColors.primary,)),
              Expanded(child: Container(color: AppColors.bgColor,)),
            ],
          ),
          EasyDateTimeLinePicker.itemBuilder(
            focusedDate: listProvider.selectedCalenderTime,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            itemExtent: 70,
            onDateChange: (date) {},
            itemBuilder: ( context, date, isSelected, isDisabled, isToday, onTap){
                return InkWell(
                  onTap: (){
                    setState(() {
                      listProvider.selectedCalenderTime = date;
                      listProvider.getTodoListFromFireStore();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Spacer(),
                        Expanded(child: Text(date.dayName,
                          style: isSelected
                            ? AppStyle.selectedCalenderStyle
                            : AppStyle.unselectedCalenderStyle,)),
                        Spacer(),
                        Expanded(child: Text(date.day.toString(),
                          style: isSelected
                            ? AppStyle.selectedCalenderStyle
                            : AppStyle.unselectedCalenderStyle)),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              },

          ),
        ],
      ),
    );
  }
   onTappedCalender(){}


}