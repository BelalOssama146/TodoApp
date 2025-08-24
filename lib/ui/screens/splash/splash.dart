import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/auth/login/login.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String routeName = "splash";


  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {
  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    return Scaffold(
      body: Image.asset(themeProvider.splashScreen),
    );
  }
}
