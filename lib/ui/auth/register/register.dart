import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/model/app_user_dm/app_user.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register", style: AppStyle.appBarTextStyle,),
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.bgColor,
        body: Column(
          children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.2,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (text) {
                  userName = text;
                },
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: "User name",
                  hintStyle: AppStyle.normalGreyTextStyle,
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
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: AppStyle.normalGreyTextStyle,
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
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: AppStyle.normalGreyTextStyle,
                ),
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                style:
                ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                ),
                onPressed: () {
                  createAccount();
                }, child:
            Text("Create account",
              style:
              AppStyle.appBarTextStyle.copyWith(fontSize: 16),)
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
        message = "The password provided is too weak.";
      } else if (authError.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
      else {
        message =
            authError.message ?? "Something went wrong please try again later";
      }
      if (context.mounted) {
        showMessage(context, title: "Error",
            body: message, posButtonTitle: "Ok");
      }
    } catch (error) {
      hideDialog(context);
      print("Error = $error");
      showMessage(context, title: "Error!",
        body: "Something went wrong please try again later",);
    }
  }

  Future addUserToFireStore(AppUser user) async {
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection(AppUser.collectionName);
    DocumentReference userDoc = userCollection.doc(user.id);
    await userDoc.set(user.toJson());
  }
}
