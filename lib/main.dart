import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/auth/login/login.dart';
import 'package:todo_app/ui/auth/register/register.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/ui/screens/splash/splash.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCujE8vTH6oGe-2Sa-MdXpbHgjmG3F1GcI",
        appId: "1:953563613665:android:7d66cb67ccd935bf982aa0",
        messagingSenderId: "todo-app-fe8b8",
        projectId: "todo-app-fe8b8"),
  );
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(ChangeNotifierProvider(
    create: (_) => ListProvider(),
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      darkTheme: ThemeData.dark(),
      routes: {
        Splash.routeName : (_) => Splash(),
        Home.routeName :  (_) => Home(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register()
      },
      initialRoute: Login.routeName,
    );
  }
}

