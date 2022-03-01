// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aqua_store/model/login_model.dart';
import 'package:aqua_store/screen/homepage.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/services/signup_apiservices.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool apiCallProcess = false;
  bool hidePassword = true;
  bool rehidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var confirmPass;

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.green.shade900,
              Colors.green.shade100,
            ])),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                          color: Colors.green[900], shape: BoxShape.circle),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 70,
                              width: 70,
                              child: Image.asset(
                                'assets/icons/user.png',
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "User Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _gap(),
                    _gap(),
                    TextFormField(
                      style: TextStyle(color: Colors.white),

                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide full name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Full Name ",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.greenAccent[400],
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: TextStyle(color: Colors.white),

                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Email is empty";
                        } else {
                          null;
                        }
                      },
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.greenAccent[400],
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        confirmPass = input;
                        if (input == null || input.isEmpty) {
                          return "Password is required";
                        } else {
                          null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: "Password ",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        // border: const OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.greenAccent[400],
                          // color: Colors.black54,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              apiCallProcess = true;
                            });
                          }
                          signUpCustomer(
                            name.text,
                            email.text,
                            password.text,
                          ).then((value) => {
                                setState(() {
                                  apiCallProcess = false;
                                }),
                                if (value.isAdmin == false)
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Congratulations ! \n ${value.name} User has been created.\n",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.green[800],
                                    ),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    ),
                                  }
                                else if (value.message ==
                                    "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Error ! \nPlease make sure every thing is correct.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                                else if (value.message == "User already Exists")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Error ! \nUser already Exists",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                              });
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(fontSize: 13),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
