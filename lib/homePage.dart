import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'loginPage.dart';

import 'schedule_add.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<String> schedulesList = <String>[
    'schedule1',
    'schedule2',
    'schedule3',
    'schedule4'
  ];

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
                  Text('My Schedule'),
                  TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleAdd()),
                        )
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
                        print('${schedulesList[index]} selected');
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
