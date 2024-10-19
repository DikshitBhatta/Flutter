import 'package:flutter/material.dart';

class MoodIcons {
  final String? title;
  final Color? color;
  final double? rotation;
  final IconData? icon;

  const MoodIcons({this.title, this.color, this.rotation, this.icon});

  int getMoodIndex(String mood) {
    return moodIconList.indexWhere((icon) => icon.title == mood);
  }

  IconData? getMoodIcon(String mood) {
    int index = getMoodIndex(mood);
    if (index >= 0 && index < moodIconList.length) {
      return moodIconList[index].icon;
    } else {
      return null;
    }
  }

  Color? getMoodColor(String mood) {
    int index = getMoodIndex(mood);
    if (index >= 0 && index < moodIconList.length) {
      return moodIconList[index].color;
    } else {
      return null;
    }
  }

  double? getMoodRotation(String mood) {
    int index = getMoodIndex(mood);
    if (index >= 0 && index < moodIconList.length) {
      return moodIconList[index].rotation;
    } else {
      return null;
    }
  }

  String getMoodTitle(String mood) {
    int index = getMoodIndex(mood);
    return index >= 0 && index < moodIconList.length
        ? moodIconList[index].title ?? 'Unknown Mood'
        : 'Unknown Mood';
  }

  List<MoodIcons> getMoodIconList() {
    return moodIconList;
  }
}

List<MoodIcons> moodIconList = <MoodIcons>[
  const MoodIcons(
      title: 'Very Satisfied',
      color: Colors.amber,
      rotation: 0.4,
      icon: Icons.sentiment_very_satisfied),
  const MoodIcons(
      title: 'Satisfied',
      color: Colors.green,
      rotation: 0.2,
      icon: Icons.sentiment_satisfied),
  const MoodIcons(
      title: 'Neutral',
      color: Colors.grey,
      rotation: 0.0,
      icon: Icons.sentiment_neutral),
  const MoodIcons(
      title: 'Dissatisfied',
      color: Colors.cyan,
      rotation: -0.02,
      icon: Icons.sentiment_dissatisfied),
  const MoodIcons(
      title: 'Very Dissatisfied',
      color: Colors.red,
      rotation: -0.04,
      icon: Icons.sentiment_very_dissatisfied),
];
