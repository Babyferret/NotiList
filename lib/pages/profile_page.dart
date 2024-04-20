import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notilist/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;

  final src =
      'https://variety.com/wp-content/uploads/2023/03/john-wick-chapter-4-keanu.jpg?w=1000&h=563&crop=1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style:
              TextStyle(color: Color(0xff7a2d2d), fontWeight: FontWeight.bold, fontFamily: 'Adamina'),
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black45, spreadRadius: 2, blurRadius: 10)
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                const Color(0xfffff4ec).withOpacity(1),
                const Color(0xffffc095).withOpacity(1),
              ])),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                profilepicture(),
                const SizedBox(height: 10),
                nametext(),
                const SizedBox(height: 15),
                notifications_button(),
                const SizedBox(height: 10),
                privacy_button(),
                const SizedBox(height: 10),
                terms_button(),
                const SizedBox(height: 10),
                support_button(),
                const SizedBox(height: 10),
                logout_button(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container notifications_button() {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          // เพิ่มฟังก์ชันในการเปลี่ยนหน้า
          print('Notifiactions Button');
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Notifications',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Color(0xff7a2d2d),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container privacy_button() {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          // เพิ่มฟังก์ชันในการเปลี่ยนหน้า
          print('Privacy Policy Button');
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Color(0xff7a2d2d),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container terms_button() {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          // เพิ่มฟังก์ชันในการเปลี่ยนหน้า
          print('Terms of service Button');
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Terms of service',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Color(0xff7a2d2d),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container support_button() {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          // เพิ่มฟังก์ชันในการเปลี่ยนหน้า
          print('Support Button');
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Support',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Color(0xff7a2d2d),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container logout_button(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 48,
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.transparent),
          color: const Color(0xffcc2929)),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          auth.signOut().then(
            (value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 20),
              onPressed: null,
              icon: Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
                // textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text nametext() {
    return Text(
      auth.currentUser?.email ?? 'No email available',
      style: const TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Stack profilepicture() {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black45, spreadRadius: 2, blurRadius: 10)
          ],
        ),
        child: CircleAvatar(
          radius: 90,
          backgroundImage: NetworkImage(src),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 125,
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, spreadRadius: 2, blurRadius: 10)
              ],
            ),
            child: const Icon(
              Icons.edit,
              color: Color(0xff33363f),
              opticalSize: 20,
            ),
          ),
          onPressed: () {},
        ),
      ),
    ]);
  }
}
