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
              TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      FlutterLogo(),
                      Text(
                        'Clock',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  ))
            ],
          ),
          VerticalDivider(
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
                  const Text(
                    'Clock',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    formattedTime,
                    style: const TextStyle(color: Colors.white, fontSize: 64),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const ClockView(),
                  const Text(
                    'Timezone',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.language,
                        color: Colors.white,
                      ),
                      Text(
                        'UTC' + offsetSign + timezoneString,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
