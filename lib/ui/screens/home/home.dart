import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/auth/login/login.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';
import 'package:todo_app/ui/screens/tabs/list_tab.dart';
import 'package:todo_app/ui/screens/tabs/settings_tab.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/widgets/add_bottom_sheet/add_bottom_sheet.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  DateTime selectedTime = DateTime.now();
  int currentIndex = 0;
  List<Widget> tabs = [ListTab(), SettingsTab()];
  late ListProvider listProvider;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30, left: 52),
          child: Text(context.locale.todoList,),
        ),
        actions: [
          InkWell(
              onTap: () {
                listProvider.reset();
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 12),
                child: Icon(Icons.logout_outlined, size: 40,
                  color: themeProvider.action,),
              ))
        ],
      ),
      body: tabs[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar:
      BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(
              Icons.list, size: 33,
              color: currentIndex == 0 ? AppColors.primary : AppColors.grey,),
              onPressed: () {
                setState(() => currentIndex = 0);
              },),
            IconButton(icon: Icon(
              Icons.settings, size: 33,
              color: currentIndex == 1 ? AppColors.primary : AppColors.grey,),
              onPressed: () {
                setState(() => currentIndex = 1);
              },),
          ],
        ),),);
  }
  buildFab() => FloatingActionButton(
    isExtended: false,
    onPressed: () {
      AddBottomSheet.show(context);
    },
    child: Icon(Icons.add),
  );
}
