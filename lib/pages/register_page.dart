import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'NothingYouCouldDo',
                  shadows: [
                    Shadow(
                        blurRadius: 15,
                        offset: Offset(2, 2),
                        color: Colors.black38)
                  ]),
              textAlign: TextAlign.center,
            ),
            const Text(
              'NotiList',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'NothingYouCouldDo',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        blurRadius: 15,
                        offset: Offset(2, 2),
                        color: Colors.black38)
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
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
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(
                      color: const Color(0xff241c1c).withOpacity(0.6),
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(
                      color: const Color(0xff241c1c).withOpacity(0.6),
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(
                      color: const Color(0xff241c1c).withOpacity(0.6),
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(315, 50),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  backgroundColor: const Color(0xff7a4d2d),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  foregroundColor: Colors.white),
              child: const Text('Register'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Already have an account ? Sign In',
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
