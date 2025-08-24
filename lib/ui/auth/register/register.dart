import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/model/app_user_dm/app_user.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const String routeName = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String userName = "";
  String email = "";
  String password = "";
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
        title: Text(context.locale.register),
        eelevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.15,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (text) {
                  userName = text;
                },
                style: TextStyle(color: themeProvider.fieldText),
                decoration: InputDecoration(
                  hintText: context.locale.userName,
                  hintStyle: AppStyle.detailsTaskTextStyle,
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (text) {
                  email = text;
                },
                style: TextStyle(color: themeProvider.fieldText),
                decoration: InputDecoration(
                  hintText: context.locale.email,
                  hintStyle: AppStyle.detailsTaskTextStyle,
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (text) {
                  password = text;
                },
                style: TextStyle(color: themeProvider.fieldText),
                decoration: InputDecoration(
                  hintText: context.locale.password,
                  hintStyle: AppStyle.detailsTaskTextStyle,
                ),
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                ),
                onPressed: () {
                  createAccount();
                }, child:
            Text(context.locale.createAccount,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium)
            ),
          ],
        )

    );
  }

  void createAccount() async {
    try {
      showLoading(context);
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,);
      AppUser newUser = AppUser(
          id: userCredential.user!.uid, email: email, userName: userName);
      await addUserToFireStore(newUser);
      AppUser.currentUser = newUser;
      hideDialog(context);
      Navigator.pushReplacementNamed(context, Login.routeName);
    } on FirebaseAuthException catch (authError) {
      hideDialog(context);
      String message = "";

      if (authError.code == 'weak-password') {
        message = context.locale.weak;
      } else if (authError.code == 'email-already-in-use') {
        message = context.locale.accountExist;
      }
      else {
        message =
            authError.message ?? context.locale.somethingWentWrong;
      }
      if (context.mounted) {
        showMessage(context, title: context.locale.error,
            body: message, posButtonTitle: context.locale.ok);
      }
    } catch (error) {
      hideDialog(context);
      print("Error = $error");
      showMessage(context, title: context.locale.error,
        body: context.locale.somethingWentWrong,);
    }
  }

  Future addUserToFireStore(AppUser user) async {
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection(AppUser.collectionName);
    DocumentReference userDoc = userCollection.doc(user.id);
    await userDoc.set(user.toJson());
  }
}
