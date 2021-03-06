import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:pts/Constant.dart';
import 'package:pts/Model/calendar_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// docs :
// connecter firebase firestore :
// https://github.com/SyncfusionExamples/appointments-to-firestore-database-flutter-calendar/blob/main/lib/main.dart
// custom agenda :
// https://github.com/SyncfusionExamples/custom-agenda-view-flutter-calendar/blob/master/lib/main.dart

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  MeetingDataSource events;
  final databaseReference = FirebaseFirestore.instance;
  List<Meeting> _appointmentDetails=<Meeting>[];

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotValue = await databaseReference
        .collection("party")
        .get();
    
    List<Meeting> list = snapShotValue.docs
      .map((e) => Meeting(  
        eventName: e.data()['Name'],
        from: e.data()['StartTime'].toDate(),
        to: e.data()['EndTime'].toDate(),
        background: SECONDARY_COLOR,
        isAllDay: false ))
      .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: SfCalendar(
              onTap: calendarTapped,
              monthViewSettings: MonthViewSettings(
                navigationDirection: MonthNavigationDirection.vertical,
              ),
              dataSource: events,
              cellBorderColor: PRIMARY_COLOR,
              view: CalendarView.month,
              initialSelectedDate: DateTime.now(),
              todayHighlightColor: SECONDARY_COLOR,
              selectionDecoration: BoxDecoration(
                border: Border.all(
                  color: SECONDARY_COLOR,
                  width: 1.5
                )
              ),
            ),
          ),
          Expanded(  
            child: Container(
              padding: EdgeInsets.only(top: 8), 
              color: Colors.white,
              child: ListView.separated(
                itemCount: _appointmentDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                '${DateFormat.E('fr_FR').format(_appointmentDetails[index].from)}',
                              ),
                              Text(
                                '${DateFormat.d('fr_FR').format(_appointmentDetails[index].from)}'
                              ),
                            ]
                          ),
                        )
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, left: 4),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(  
                              color: SECONDARY_COLOR,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _appointmentDetails[index].eventName,
                                  style: TextStyle(  
                                    color: ICONCOLOR
                                  ),
                                ),
                                Text(
                                  '${DateFormat.Hm('fr_FR').format(_appointmentDetails[index].from)}',
                                  style: TextStyle(  
                                    color: ICONCOLOR
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                    ]
                  );
                }, 
                separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    height: 5,
                  )
              ),
            ),
          ),
        ]
      )
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _appointmentDetails = calendarTapDetails.appointments.cast<Meeting>();
      });
    }
  }
}
