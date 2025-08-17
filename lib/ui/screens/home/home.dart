import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/auth/login/login.dart';
import 'package:todo_app/ui/model/app_user_dm/app_user.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/tabs/list_tab.dart';
import 'package:todo_app/ui/screens/tabs/settings_tab.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/widgets/add_bottom_sheet/add_bottom_sheet.dart';

import '../../utils/app_styles.dart';

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

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Padding(
          padding: const EdgeInsets.only(top: 30,left: 60),
          child: Text("Welcome back ${AppUser.currentUser!.userName}",
              style: AppStyle.appBarTextStyle),
        ),
        actions: [
          InkWell(
              onTap: () {
                listProvider.reset();
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              child: Icon(Icons.logout_outlined, size: 40,))
        ],
      ),
      body: tabs[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildNavigationBar() => BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (onTapped) {
      currentIndex = onTapped;
      setState(() {});
    },
    elevation: 0,
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.grey,
    selectedIconTheme: IconThemeData(size: 33),
    unselectedIconTheme: IconThemeData(size: 33),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings",),
    ],
  );

  buildFab() => FloatingActionButton(
    isExtended: false,
    onPressed: () {
      AddBottomSheet.show(context);
    },
    backgroundColor: Colors.blue,
    shape: StadiumBorder(side: BorderSide(color: AppColors.white, width: 5)),
    child: Icon(Icons.add, color: AppColors.white),
  );
}
