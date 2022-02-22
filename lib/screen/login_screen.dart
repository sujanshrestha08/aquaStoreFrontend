// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aqua_store/admin/admin_home.dart';
import 'package:aqua_store/screen/homepage.dart';
import 'package:aqua_store/screen/sign_up.dart';
import 'package:aqua_store/services/login_apiservices.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email;
  var password;
  bool hidePassword = true;
  bool apiCallProcess = false;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
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
                            "User Login",
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
                      style: const TextStyle(color: Colors.white),

                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "User Name is empty";
                        } else {
                          null;
                        }
                      },
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "User Name ",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.greenAccent[400],
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _password,
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => password = input,
                      autofillHints: const [AutofillHints.password],
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Password is required";
                        } else {
                          null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        // border: const OutlineInputBorder(),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.greenAccent[400],
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
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              apiCallProcess = true;
                            });
                            await login(
                              _email.text.toString(),
                              _password.text.toString(),
                            ).then((value) => {
                                  setState(() {
                                    apiCallProcess = false;
                                  }),
                                  if (value.isAdmin == true)
                                    {
                                      SharedServices.setLoginDetails(
                                          value.token),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminHomePage()),
                                      ),
                                    }
                                  else if (value.isAdmin == false)
                                    {
                                      SharedServices.setLoginDetails(
                                          value.token),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      ),
                                    }
                                });
                          }
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                // color: Color(0xfff06127),
                              )
                            : const Text(
                                "Login",
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
                          // fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(fontSize: 14),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()),
                                  ),
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

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
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
