import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';
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
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(context.locale.login,),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 3,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(context.locale.welcomeBack,
                  style: TextStyle(color: themeProvider.welcome, fontSize: 21)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                onChanged: (text) {
                  email = text;
                },
                style: TextStyle(color: themeProvider.fieldText),
                decoration: InputDecoration(
                  hintText: context.locale.email,
                  hintStyle: AppStyle.detailsTaskTextStyle,
                ),
                validator: (text) {
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(email);
                  if (text == null || text.isEmpty == true) {
                    return context.locale.emailsCanNotBeEmpty;
                  }
                  if (!emailValid) {
                    return context.locale.pleaseEnterAValidEmail;
                  }
                  return null;
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  password = text;
                },
                style: TextStyle(color: themeProvider.fieldText),
                decoration: InputDecoration(
                  hintText: context.locale.password,
                  hintStyle: AppStyle.detailsTaskTextStyle,
                ),
                validator: (password) {
                  if (password == null || password.isEmpty == true) {
                    return context.locale.emptyPasswordsAreNotAllowed;
                  }
                  if (password.length < 8) {
                    return context.locale.passwordsCanNotBeLesThanCharacters;
                  }
                  return null;
                },
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              onPressed: () {
                signUp();
              },
              child: Text(
                context.locale.signIn,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.locale.account,
                    style: themeProvider.account,
                  ),
                  SizedBox(width: 12,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                    child: Text(
                      context.locale.signUp,
                      style: AppStyle.selectedCalenderStyle,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 5,),
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
        message = context.locale.checkCredential;
      } else {
        message =
            authError.message ?? context.locale.somethingWentWrong;
      }
      if (context.mounted) {
        showMessage(
          context,
          title: context.locale.error,
          body: message,
          posButtonTitle: context.locale.ok,
        );
      }
    } catch (error) {
      hideDialog(context);
      print("Error = $error");
      showMessage(
        context,
        title: context.locale.error,
        body: context.locale.somethingWentWrong,
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
