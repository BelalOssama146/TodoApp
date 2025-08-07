import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../home/home.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  static const String routeName = "register";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
          title: Text("Register",style: AppStyle.appBarTextStyle,),
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.bgColor,
        body:Column(
          children: [
            Spacer(flex: 3,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "User name",
                hintStyle: AppStyle.normalGreyTextStyle,
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: AppStyle.normalGreyTextStyle,
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: AppStyle.normalGreyTextStyle,
              ),
            ),
            Spacer(flex: 3,),
            ElevatedButton(
                style:
                ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(AppColors.primary),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, Home.routeName);
                }, child:
            Text("Create account",
              style:
              AppStyle.appBarTextStyle.copyWith(fontSize: 16),)
            ),
          ],
        )

    );
  }
}
