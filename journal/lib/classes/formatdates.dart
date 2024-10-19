import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatdates {
  String? dateFormatShortMonthDayYear(String date) {
    try {
      if (date != null) {
        return DateFormat.yMMMEd().format(DateTime.parse(date));
      }
    } catch (e) {
      print('Error parseing date: $e');
    }
    return null;
  }

  String? dateFormatDayNumber(String date) {
    try {
      if (date != null) {
        return DateFormat.d().format(DateTime.parse(date));
      }
    } catch (e) {
      print('Error parseing date: $e');
    }
    return null;
  }

  String? dateFormatShortDayName(String date) {
    try {
      if (date != null) {
        return DateFormat.E().format(DateTime.parse(date));
      }
    } catch (e) {
      print('Error parseing date: $e');
    }
    return null;
  }
}
