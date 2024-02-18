import 'dart:convert';

AlarmInfo alarmInfoFromJson(String str) => AlarmInfo.fromMap(json.decode(str));
String alarmInfoToJson(AlarmInfo data) => json.encode(data.toMap());

class AlarmInfo {
  int? id;
  String? title;
  DateTime? alarmDateTime;
  bool? isPending;
  int? gradientColorIndex;
  // String? description;
  // bool? isActive;
  // List<Color> gradientColors;

  AlarmInfo({
    this.alarmDateTime,
    this.gradientColorIndex,
    this.id,
    this.isPending,
    this.title,
  });
  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json['id'],
        title: json['titile'],
        alarmDateTime: DateTime.parse(json['alarmDateTime']),
        isPending: json['isPending'],
        gradientColorIndex: json['gradientColorIndex'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'alarmDateTime': alarmDateTime!.toIso8601String(),
        'isPending': isPending,
        'gradientColorIndex': gradientColorIndex,
      };
}
