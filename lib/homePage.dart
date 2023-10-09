import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:scheduler/main.dart';
import 'loginPage.dart';

import 'schedule_add.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {

  String currentSchedule = "";

  final List<String> schedulesList = <String>[
    '일회성 일정',
    '주간 일정',
  ];

  @override
  void initState() {
    super.initState();
    print("init");
    _loadSchedule(0);
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  //loads the schedule of the corresponding index onto the schedule view
  void _loadSchedule(int scheduleIndex) {
    setState(() {
      currentSchedule = schedulesList[scheduleIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
        return CalendarControllerProvider(
      controller: EventController(),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Text(currentSchedule)),
                  TextButton(
                      onPressed: () => {
                        showDialog(
                          context: context, 
                          builder: (BuildContext) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text("일정 추가"),
                              content: Padding(
                                padding: EdgeInsets.all(8),
                                child: AddAppointmentDialog()
                                ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop(); //closes the popup
                                  }, 
                                  child: Text("추가"))
                              ],
                            );
                          })
                      },
                      child: Text('스케줄 추가'))
                ],
              ),
            ),
            Expanded(
                flex: 7,
                child: WeekView(
                  width: 450,
                  heightPerMinute: 0.5,
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('예정된 스케줄'),
                )),
            Expanded(
              flex: 5,
              child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: schedulesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: Text(schedulesList[index]),
                      onTap: () {
                        _loadSchedule(index);
                      },
                    );
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Text('로그인'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }),
              );
            }),
      ),
    );
  }

}

class AddAppointmentDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddAppointmentDialogState();
  }

}

class _AddAppointmentDialogState extends State<AddAppointmentDialog>{

  List<CreateChunkRow> chunkRows = [CreateChunkRow()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: chunkRows
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                chunkRows.add(CreateChunkRow());
              });
            },
          ),
        )
      ]);
    
  }

}

class CreateChunkRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateChunkRow();
  }
}

class _CreateChunkRow extends State<CreateChunkRow> {

  late TimeOfDay startTime, endTime;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay(hour: startTime.hour+1, minute: startTime.minute);
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text((date.year != MyApp.nowYear ? "${date.year}\n" : "") + "${date.month}/${date.day}")
            ),
            TextButton(
              onPressed: () {},
              child: Text(MyApp.formatTime(startTime.hour, startTime.minute))
            ),
            Text("~"),
            TextButton(
              onPressed: () {},
              child: Text(MyApp.formatTime(endTime.hour, endTime.minute))
            ),
          ],
      );
  }
}

