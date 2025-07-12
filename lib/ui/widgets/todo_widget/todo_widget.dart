import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

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
            color: AppColors.primary,
            ),
          SizedBox(width: 24,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Play Basketball ",style: AppStyle.listTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,),
                SizedBox(height: 8,),
                Text("Description ",style: AppStyle.listDateTextStyle,),
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
