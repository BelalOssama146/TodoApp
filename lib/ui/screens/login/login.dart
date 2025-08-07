import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/ui/screens/register/register.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static const String routeName = "login";
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text("Login",style: AppStyle.appBarTextStyle,),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppColors.bgColor,
      body:Column(
        children: [
          Spacer(flex: 2,),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text("Welcome back!" ,style: AppStyle.loginTitle, ),
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
          SizedBox(height: 8,),
          ElevatedButton(
            style: 
            ButtonStyle(
                backgroundColor:WidgetStatePropertyAll(AppColors.primary),
            ),
            onPressed: (){
            Navigator.pushReplacementNamed(context, Home.routeName);
          }, child: 
          Text("Login",
            style: 
            AppStyle.appBarTextStyle.copyWith(fontSize: 16),)
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, Register.routeName);
            },
            child: Text("Create account",style: AppStyle.normalGreyTextStyle,),
          )
        ],
      )

    );
  }
}
