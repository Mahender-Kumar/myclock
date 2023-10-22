import 'package:flutter/material.dart';
import 'package:myclock/data.dart';
import 'package:myclock/theme_data.dart';

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
              children: alarms.map(
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.circular(24)),
                  child: TextButton(
                    onPressed: () {},
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
                )
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
