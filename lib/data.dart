import 'package:myclock/enums.dart';
import 'package:myclock/models/alarm_info.dart';
import 'package:myclock/models/menu_info.dart';
 

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imagesource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imagesource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imagesource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imagesource: 'assets/stopwatch_icon.png'),
];
List<AlarmInfo> alarms = [
  AlarmInfo(
    alarmDateTime:
      DateTime.now().add(
        const Duration(hours: 1),
      ),
      title: 'Office',
      gradientColorIndex: 0),
  AlarmInfo(
     alarmDateTime: DateTime.now().add(
        const Duration(hours: 2),
      ),
      title: 'Sport',
      gradientColorIndex: 1),
];
