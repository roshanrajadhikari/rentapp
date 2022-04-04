import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_app/theme/colors.dart';
import '../utils/utils.dart';

class Calender_Widget extends StatefulWidget {
  @override
  _Calender_WidgetState createState() => _Calender_WidgetState();
}

class _Calender_WidgetState extends State<Calender_Widget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
          canMarkersOverflow: true,
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primary.withOpacity(0.7),
          ),
          selectedDecoration:
              BoxDecoration(shape: BoxShape.circle, color: primary),
          todayTextStyle: TextStyle(color: Colors.white)),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}
