import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatdates {
  String? dateFormatShortMonthDayYear(String date) {
    DateFormat.yMMMEd().format(DateTime.parse(date));
    return null;
  }

  String? dateFormatDayNumber(String date) {
    DateFormat.d().format(DateTime.parse(date));
    return null;
  }

  String? dateFormatShortDayName(String date) {
    DateFormat.E().format(DateTime.parse(date));
    return null;
  }
}
