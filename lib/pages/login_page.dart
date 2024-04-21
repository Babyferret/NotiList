import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:notilist/main.dart';
import 'package:notilist/models/profile.dart';
import 'package:notilist/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var validaccount = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: const Color(0xfffff9f2),
              body: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        welcometext(),
                        notilisttext(),
                        const SizedBox(height: 15),
                        emailbox(),
                        const SizedBox(height: 20),
                        passwordbox(),
                        if (validaccount)
                          const Text(
                            'Passwords do not Match',
                            style: TextStyle(color: Colors.red),
                            textHeightBehavior: TextHeightBehavior(),
                          ),
                        const SizedBox(height: 20),
                        signin(),
                        const SizedBox(height: 20),
                        signup(context),
                        const SizedBox(height: 20),
                        forgetpassword()
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Text forgetpassword() {
    return const Text(
      'Forget Password?',
      style: TextStyle(fontSize: 12, color: Color(0xff7a4d2d)),
    );
  }

  ElevatedButton signup(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const RegisterPage();
        }));
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(315, 50),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xfff4d3bd),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          foregroundColor: Colors.black),
      child: const Text('Sign Up'),
    );
  }

  ElevatedButton signin() {
    return ElevatedButton(
      onPressed: () async {
        formKey.currentState?.save();
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: profile.email, password: profile.password)
                .then((value) {
              formKey.currentState!.reset();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MainPage();
              }));
            });
          } on FirebaseAuthException catch (e) {
            setState(() {
              validaccount = true;
            });
            print(e.message);
          }
        }
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(315, 50),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xff7a4d2d),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          foregroundColor: Colors.white),
      child: const Text('Sign In'),
    );
  }

  Container passwordbox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black),
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.0,
              blurRadius: 2.0,
            )
          ]),
      child: TextFormField(
        validator:
            RequiredValidator(errorText: 'Please enter your Password').call,
        obscureText: true,
        onChanged: (password) {
          profile.password = password;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Enter Password',
          hintStyle: TextStyle(
              color: const Color(0xff241c1c).withOpacity(0.6), fontSize: 14),
        ),
      ),
    );
  }

  Container emailbox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black),
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.0,
              blurRadius: 2.0,
            )
          ]),
      child: TextFormField(
        validator: MultiValidator([
          EmailValidator(errorText: 'Email not correct'),
          RequiredValidator(errorText: 'Please enter your Email')
        ]).call,
        keyboardType: TextInputType.emailAddress,
        onChanged: (email) {
          profile.email = email;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Enter Email',
          hintStyle: TextStyle(
              color: const Color(0xff241c1c).withOpacity(0.6), fontSize: 14),
        ),
      ),
    );
  }

  Text notilisttext() {
    return const Text(
      'NotiList',
      style: TextStyle(
          fontSize: 35,
          fontFamily: 'NothingYouCouldDo',
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(blurRadius: 15, offset: Offset(2, 2), color: Colors.black38)
          ]),
    );
  }

  Text welcometext() {
    return const Text(
      'Welcome',
      style: TextStyle(fontSize: 20, fontFamily: 'NothingYouCouldDo', shadows: [
        Shadow(blurRadius: 15, offset: Offset(2, 2), color: Colors.black38)
      ]),
      textAlign: TextAlign.center,
    );
  }
}
