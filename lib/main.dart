import 'package:flutter/material.dart';
import 'package:notilist/pages/login_page.dart';
import 'package:notilist/pages/profile_page.dart';
import 'package:notilist/pages/my_note_page.dart';
import 'package:notilist/pages/my_to_do.dart';
import 'package:notilist/pages/my_calendar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // home: MainPage(), // Updated to use MainPage
        home: LoginPage());
  }
}

class RoundedNavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoundedNavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Calendar(),
    const TodoList(),
    const NoteList(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundedNavItem(
                icon: Icons.calendar_today,
                isSelected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              RoundedNavItem(
                icon: Icons.check_box,
                isSelected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              RoundedNavItem(
                icon: Icons.note,
                isSelected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              RoundedNavItem(
                icon: Icons.person,
                isSelected: _selectedIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
