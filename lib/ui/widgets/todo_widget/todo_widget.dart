import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import '../../model/todo_dm/todo_model.dart';
import '../../utils/app_colors.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel item;
  const TodoWidget({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 22,horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 18),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 62,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            ),
          SizedBox(width: 25,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,style: AppStyle.listTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,),
                SizedBox(height: 8,),
                Text(item.description,style: AppStyle.listDateTextStyle,),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
              child: Icon(Icons.check,color: AppColors.white,size: 34,))
        ],
      ),
    );
  }
}
