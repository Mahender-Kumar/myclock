import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myclock/clock_view.dart';
import 'package:myclock/data.dart';
import 'package:myclock/enums.dart';
import 'package:myclock/menu_info.dart';
import 'package:myclock/theme_data.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = ' ';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    // print(timezoneString);

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()
              // <Widget>[
              //   buildMenuButton('Clock', 'assets/clock_icon.png'),
              //   buildMenuButton('Alarm', 'assets/alarm_icon.png'),
              //   buildMenuButton('Timer', 'assets/timer_icon.png'),
              //   buildMenuButton('Stopwatch', 'assets/stopwatch_icon.png'),
              // ],
              ),
          const VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType != MenuType.clock) return Container();
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  alignment: Alignment.center,
                  color: const Color(0xFF2D2F41),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          'Clock',
                          style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                  fontSize: 64),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: ClockView(
                            size: MediaQuery.of(context).size.height / 5,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Timezone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  'UTC' + offsetSign + timezoneString,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: currentMenuInfo.menuType == value.menuType
                ? CustomColors.menuBackgroundColor
                : Colors.transparent,
          ),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imagesource!,
                scale: 1.5,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title!,
                style: const TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 14),
              )
            ],
          ),
        );
      },
    );
  }
}
