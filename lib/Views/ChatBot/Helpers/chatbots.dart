import 'package:flutter/material.dart';

class ChatBots{
  static const List<String> botNames = ['General', 'Tour Agent', 'Stay Specialist', 'Trip Specialist', 'Place Specialist', 'Shop Specialist'];

  static const Map<String, String> _chatBotImages = {
    'General': 'assets/images/bot_images/general.png',
    'Tour Agent': 'assets/images/bot_images/tour_agent.png',
    'Stay Specialist': 'assets/images/bot_images/stay_specialist.png',
    'Trip Specialist': 'assets/images/bot_images/trip_specialist.png',
    'Place Specialist': 'assets/images/bot_images/place_specialist.png',
    'Shop Specialist': 'assets/images/bot_images/shopping_specialist.png',
  };

  static const Map<String, Color> _chatBotColors = {
    'General': Colors.red,
    'Tour Agent': Colors.blue,
    'Stay Specialist': Colors.green,
    'Trip Specialist': Colors.grey,
    'Place Specialist': Colors.purple,
    'Shop Specialist': Colors.orange,
  };

  static String getBotImage(String key){
    return _chatBotImages[key]!;
  }

  static Color getBotColor(String key){
    return _chatBotColors[key]!;
  }

}