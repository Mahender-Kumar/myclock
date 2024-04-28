import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:myclock/alarm_helper.dart';
import 'package:myclock/data.dart';
import 'package:myclock/main.dart';
import 'package:myclock/models/alarm_info.dart';
import 'package:myclock/theme_data.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;
  String _alarmTimeString = '';
  bool _isRepeatSelected = false;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  // List<AlarmInfo>? _currentAlarms;
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      if (kDebugMode) {
        print('------database intialized-------');
      }
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();

    if (mounted) setState(() {});
  }

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
            child: FutureBuilder(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.map<Widget>(
                        (alarm) {
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex!]
                              .colors;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            // color: Colors.blue,
                            // height: 100,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColor,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(24),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          gradientColor.last.withOpacity(0.4),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                      offset: const Offset(4, 4))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${alarm.alarmDateTime!.hour}:${alarm.alarmDateTime!.minute}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'avenir',
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _alarmHelper.delete(alarm.id!);
                                          loadAlarms();
                                        },
                                        icon: const Icon(Icons.delete,
                                            size: 36, color: Colors.white)),
                                    // Icon(Icons.keyboard_arrow_down,
                                    //     size: 36, color: Colors.white)
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
                          dashPattern: const [5, 4],
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
                                _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  var selectedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );
                                                  if (selectedTime != null) {
                                                    final now = DateTime.now();
                                                    var selectedDateTime =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            selectedTime.hour,
                                                            selectedTime
                                                                .minute);
                                                    _alarmTime =
                                                        selectedDateTime;
                                                    setModalState(() {
                                                      _alarmTimeString =
                                                          DateFormat('HH:mm')
                                                              .format(
                                                                  selectedDateTime);
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  _alarmTimeString,
                                                  style: const TextStyle(
                                                      fontSize: 32),
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('Repeat'),
                                                trailing: Switch(
                                                  onChanged: (value) {
                                                    setModalState(() {
                                                      _isRepeatSelected = value;
                                                    });
                                                  },
                                                  value: _isRepeatSelected,
                                                ),
                                              ),
                                              const ListTile(
                                                title: Text('Sound'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              const ListTile(
                                                title: Text('Title'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: () {
                                                  onSaveAlarm(
                                                      _isRepeatSelected);
                                                },
                                                icon: const Icon(Icons.alarm),
                                                label: const Text('Save'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );

                                // scheduleAlarm();
                                // _zonedScheduleNotification();
                                // _zonedScheduleAlarmClockNotification();
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
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]).toList(),
                    );
                  }
                  return const Text('Loading...');
                }),
          ),
        ],
      ),
    );
  }

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    // print('clicked1');
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(const Duration(seconds: 30));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif', channelDescription: 'repeating description',
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
    // print(scheduledNotificationDateTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        scheduledNotificationDateTime.toString(),
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Future<void> _zonedScheduleNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled this title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'your channel id', 'your channel name',
  //               channelDescription: 'your channel description')),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // Future<void> _zonedScheduleAlarmClockNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       123,
  //       'scheduled alarm clock title',
  //       'scheduled alarm clock body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'alarm_clock_channel', 'Alarm Clock Channel',
  //               channelDescription: 'Alarm Clock Notification')),
  //       androidScheduleMode: AndroidScheduleMode.alarmClock,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  void onSaveAlarm(bool isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }
    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: alarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime!, alarmInfo);
    // print('object');
    Navigator.pop(context);
    loadAlarms();
  }
}
