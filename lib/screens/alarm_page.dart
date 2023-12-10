import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myclock/data.dart';
import 'package:myclock/main.dart';
import 'package:myclock/theme_data.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>(
                (alarm) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // color: Colors.blue,
                    // height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: alarm.gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: alarm.gradientColors.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: const Offset(4, 4))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Office',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir',
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                                activeColor: Colors.white,
                                value: true,
                                onChanged: (bool value) {})
                          ],
                        ),
                        const Text(
                          'Mon-Fri',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '07:00 AM',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'avenir',
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                size: 36, color: Colors.white)
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ).followedBy([
                DottedBorder(
                  strokeWidth: 2,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  dashPattern: [5, 4],
                  radius: const Radius.circular(24),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: CustomColors.clockBG,
                        borderRadius: BorderRadius.circular(24)),
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      )),
                      onPressed: () {
                        // scheduleAlarm();
                        // _zonedScheduleNotification();
                        _zonedScheduleAlarmClockNotification();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/add_alarm.png',
                            scale: 1.5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Add Alarm',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scheduleAlarm() async {
    print('clicked1');
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 30));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      icon: 'mipmap/ic_launcher',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_string'),
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      importance: Importance.max,
      priority: Priority.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    // var IOSPlatformChannelSpecifics = IOSNotificationsDetails(
    //   sound:'a_long_cold_string',
    //   presentAlert:true,
    //   presentBadge:true,
    //   presentSound:true,
    // );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        scheduledNotificationDateTime.toString(),
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled this title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _zonedScheduleAlarmClockNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        123,
        'scheduled alarm clock title',
        'scheduled alarm clock body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'alarm_clock_channel', 'Alarm Clock Channel',
                channelDescription: 'Alarm Clock Notification')),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
