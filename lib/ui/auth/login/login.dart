import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

import '../../model/app_user_dm/app_user.dart';
import '../../screens/home/home.dart';
import '../../utils/dialog_utils.dart';
import '../register/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String routeName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: AppStyle.appBarTextStyle),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppColors.bgColor,
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: MediaQuery.of(context).size.height * 0.1),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Welcome back!", style: AppStyle.loginTitle),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                onChanged: (text) {
                  email = text;
                },
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: AppStyle.normalGreyTextStyle,
                ),
                validator: (text) {
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(email);
                  if (text == null || text.isEmpty == true) {
                    return "emails can not be empty";
                  }
                  if (!emailValid) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                onChanged: (text) {
                  password = text;
                },
                style: TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: AppStyle.normalGreyTextStyle,
                ),
                validator: (password) {
                  if (password == null || password.isEmpty == true) {
                    return "Empty passwords are not allowed";
                  }
                  if (password.length < 8) {
                    return "passwords can not be less than 8 characters";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              onPressed: () {
                signUp();
              },
              child: Text(
                "Login",
                style: AppStyle.appBarTextStyle.copyWith(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Register.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Create account",
                  style: AppStyle.normalGreyTextStyle.copyWith(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser.currentUser = await getUserFromFireStore(
        userCredential.user!.uid,
      );
      hideDialog(context);
      Navigator.pushReplacementNamed(context, Home.routeName);
    } on FirebaseAuthException catch (authError) {
      print("fireException = ${authError.code}");
      hideDialog(context);
      String message = "";
      if (authError.code == "invalid-credential") {
        message = "Wrong email or password please double check your creds.";
      } else {
        message =
            authError.message ?? "Something went wrong please try again later";
      }
      if (context.mounted) {
        showMessage(
          context,
          title: "Error",
          body: message,
          posButtonTitle: "Ok",
        );
      }
    } catch (error) {
      hideDialog(context);
      print("Error = $error");
      showMessage(
        context,
        title: "Error!",
        body: "Something went wrong please try again later",
      );
    }
  }

  Future<AppUser> getUserFromFireStore(String id) async {
    CollectionReference userCollection = FirebaseFirestore.instance.collection(
      AppUser.collectionName,
    );
    DocumentReference userDoc = userCollection.doc(id);
    DocumentSnapshot snapshot = await userDoc.get();
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return AppUser.fromJson(json);
  }
}
