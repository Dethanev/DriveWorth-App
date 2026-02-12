import 'package:flutter/material.dart';

class MoodData {
  final String asset; 
  final String moodText;
  final Color moodColor;
  final String buttonText;
  final String image;

  MoodData({
    required this.asset,
    required this.moodText,
    required this.moodColor,
    required this.buttonText,
    required this.image, 
  });
}

final List<MoodData> moodData = [
  MoodData(
    asset: 'assets/animations/verygood.json',
    moodText: 'Very good!',
    moodColor: Colors.black, 
    buttonText: 'Select',
    image: 'assets/emojis/verygood.png', 
  ),
  MoodData(
    asset: 'assets/animations/good.json',
    moodText: 'Good!',
    moodColor: Colors.black,
    buttonText: 'Select',
    image: 'assets/emojis/good.png', 
  ),
  MoodData(
    asset: 'assets/animations/notgood.json',
    moodText: 'Not good...',
    moodColor: Colors.black,
    buttonText: 'Select',
    image: 'assets/emojis/notgood.png', 
  ),
  MoodData(
    asset: 'assets/animations/awful.json',
    moodText: 'Awful!',
    moodColor: Colors.black,
    buttonText: 'Select',
    image: 'assets/emojis/awful.png', 
  ),
  MoodData(
    asset: 'assets/animations/angry.json',
    moodText: 'Angry!',
    moodColor: Colors.black,
    buttonText: 'Select',
    image: 'assets/emojis/angry.png', 
  ),
];

