import 'package:engineering_hub/backend/api_calls.dart';
import 'package:engineering_hub/model/message_model.dart';
import 'package:flutter/material.dart';

String getTime(String timeStamp) {
  TimeOfDay time = TimeOfDay.fromDateTime(DateTime.parse(timeStamp));
  int hour = time.hourOfPeriod;
  int minutes = time.minute;
  String amPm = (time.hour > 12) ? "PM" : "AM";
  return '$hour:$minutes $amPm';
}

Stream<List<Message>> streamOfMessages(
    {bool? newChat, String? clg, String? branch, String? sem}) async* {
  print("getting message");
  // while (true) {
  //   await Future.delayed(const Duration(seconds: 1));
  //   if (newChat ?? false) {
  //     yield await Api().getMessage(
  //       clg: clg,
  //       brn: branch,
  //       sem: sem,
  //     );
  //   } else {
  //     yield await Api().getMessage();
  //   }
  // }
  yield await Api().getMessage();
}

String getDate(String dateStamp) {
  try {
    DateTime stamp = DateTime.parse(dateStamp);
    int date = stamp.day;
    String month = getMonth(stamp.month);
    int year = stamp.year;
    return '$date $month $year';
  } catch (e) {
    return dateStamp;
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Unknown Month';
  }
}
