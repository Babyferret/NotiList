import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:notilist/models/profile.dart';
import 'package:notilist/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  var confirmpass;
  bool passwordMatchError = false;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
                        registertext(),
                        notilisttext(),
                        const SizedBox(height: 15),
                        emailbox(),
                        const SizedBox(height: 20),
                        passwordbox(),
                        const SizedBox(height: 20),
                        c_passwordbox(),
                        if (passwordMatchError)
                          const Text(
                            'Passwords do not Match',
                            style: TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 20),
                        registerbutton(),
                        const SizedBox(height: 20),
                        signintext(context),
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

  RichText signintext(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(fontSize: 12, color: Colors.black),
            children: [
          const TextSpan(text: 'Already have an account ? '),
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: Color(0xff7a2d2d)),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                })
        ]));
  }

  ElevatedButton registerbutton() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          if (profile.password == confirmpass) {
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: profile.email, password: profile.password);
              formKey.currentState!.reset();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            } on FirebaseAuthException catch (e) {
              print(e.message);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email has already exist')));
              formKey.currentState!.reset();
            }
          } else {
            setState(() {
              passwordMatchError = true;
            });
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
      child: const Text('Register'),
    );
  }

  Container c_passwordbox() {
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
        obscureText: true,
        onChanged: (password) {
          confirmpass = password;
        },
        validator:
            RequiredValidator(errorText: 'Please enter your Comfirm Password')
                .call,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Confirm Password',
          hintStyle: TextStyle(
              color: const Color(0xff241c1c).withOpacity(0.6), fontSize: 14),
        ),
      ),
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
        validator: MultiValidator([
          RequiredValidator(errorText: 'Please enter your Password'),
          MinLengthValidator(6,
              errorText: 'Password must be at least 6 characters')
        ]).call,
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
          EmailValidator(errorText: 'Email format not correct'),
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

  Text registertext() {
    return const Text(
      'Register',
      style: TextStyle(fontSize: 20, fontFamily: 'NothingYouCouldDo', shadows: [
        Shadow(blurRadius: 15, offset: Offset(2, 2), color: Colors.black38)
      ]),
      textAlign: TextAlign.center,
    );
  }
}
