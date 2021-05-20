import 'package:flutter/material.dart';
import 'package:pts/Constant.dart';
import 'package:pts/Model/components/CalendarWidget.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: PRIMARY_COLOR, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Calendrier',
          style: TextStyle(
            color: SECONDARY_COLOR,
            ),
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.add,
              color: ICONCOLOR,
              size: 30,
            ),
          )
        ],
      ),
      body: CalendarWidget(),
    );
  }
}