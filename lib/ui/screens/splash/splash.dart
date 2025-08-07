import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/login/login.dart';
import 'package:todo_app/ui/screens/register/register.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String routeName = "splash";

  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacementNamed(context, Register.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Image.asset("assets/images/splash.png"),
    );
  }
}
