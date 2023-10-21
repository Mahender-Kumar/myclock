import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myclock/clock_view.dart';

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
            children: <Widget>[
              buildMenuButton('Clock', 'assets/clock_icon.png'),
              buildMenuButton('Alarm', 'assets/alarm_icon.png'),
              buildMenuButton('Timer', 'assets/timer_icon.png'),
              buildMenuButton('Stopwatch', 'assets/stopwatch_icon.png'),
            ],
          ),
          const VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(String title, String imagePath) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: title == 'Clock' ? Colors.teal : Colors.transparent,
        ),
        onPressed: () {},
        child: Column(
          children: [
            Image.asset(
              imagePath,
              scale: 1.5,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title ?? '',
              style: const TextStyle(
                  fontFamily: 'avenir', color: Colors.white, fontSize: 14),
            )
          ],
        ));
  }
}
