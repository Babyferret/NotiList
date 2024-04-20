import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notilist/weather.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  final src =
      'https://variety.com/wp-content/uploads/2023/03/john-wick-chapter-4-keanu.jpg?w=1000&h=563&crop=1';
  String date = DateFormat("MMMM d, yyyy").format(DateTime.now());
  final auth = FirebaseAuth.instance;
  final WeatherFactory wf = WeatherFactory(api);
  Weather? weather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("Bangkok").then((w) {
      setState(() {
        weather = w;
      });
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff7a00).withOpacity(0.3),
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'My Calendar,',
                        style: TextStyle(
                            color: Color(0xff7a2d2d),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        auth.currentUser?.email ?? 'No email available',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(src),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.device_thermostat),
                  if (weather != null)
                    Text(
                      "${weather?.temperature!.celsius!.toStringAsFixed(2)} °C  |  $date",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (weather == null)
                    Text(
                      'N/A °C  |  $date',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              )
            ],
          ),
        ),
        toolbarHeight: 140,
        elevation: 0.0,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
          height: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xffff7a00).withOpacity(0.3),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffffefdb),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      // color: Color(0xFFBBDDFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: calendar_table(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableCalendar<dynamic> calendar_table() {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        defaultTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        weekNumberTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        weekendTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        outsideTextStyle: const TextStyle(
            color: Colors.black12,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xfff7e1d2), width: 4)),
        todayTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff7e1d2),
        ),
        selectedTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
      ),
      rowHeight: 56,
      daysOfWeekHeight: 20,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, fontFamily: "Poppins"),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
        weekendStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins"),
      ),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      focusedDay: today,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      onDaySelected: _onDaySelected,
    );
  }
}
