// lib/src/theme/colors.dart
import 'package:flutter/material.dart';
import 'package:color_type_converter/color_type_converter.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static const Map<int, Map<String, Color>> themes = {
    0: {
      'navigationBarBackground': Color(0xFF13112F),
      // 'navigationBarBackground': HexColor("#1F043A"),
      'pageBackground': Color(0xFF38036D),
      'cardBackground': Color(0xFF2D0259),
      'cardChatBot': Color(0xFF38036D),
      'messageUserBackground': Color(0xFF13112F),
      'messageBotBackground': Color(0xFF1E0101),
      'headerBackground': Color(0xFFFFA6DB),
      'headerCircle1': Color(0xFFE1C9FF),
      'headerCircle2': Color(0xFFB57DFE),
      'headerCircle3': Color(0xFFD9D9D9),
      'primaryText': Colors.white,
      'secondaryText': Colors.white70,
      'chatBubbleBackground': Colors.blue,
      'footerBackground': Colors.blue,

    },
    1: {
      'navigationBarBackground': Color(0xFFFF39C7),
      // 'navigationBarBackground': HexColor("#FF69B4"),
      // 'navigationBarBackground': ColorConverter<Color>().convert('#D04CD9'),
      'pageBackground': Color(0xFFFFC0CB),
      'cardBackground': Color(0xFFFFB6C1),
      'cardChatBot': Color(0xFFFFFFFF),
      'messageUserBackground': Color(0xFFFF39C7),
      'messageBotBackground': Color(0xFFFF39C7),
      'headerBackground': Color(0xFFFFE4E1),
      'headerCircle1': Color(0xFFFFDAB9),
      'headerCircle2': Color(0xFFFFA07A),
      'headerCircle3': Color(0xFFF08080),
      'primaryText': Colors.black,
      'secondaryText': Colors.black87,
      'chatBubbleBackground': Colors.pinkAccent,
      'footerBackground': Colors.pinkAccent,

    },
    2: {
      'navigationBarBackground': Color(0xFFD98A19),
      'pageBackground': Color(0xFFFFF9C4),
      'cardBackground': Color(0xFFFFF59D),
      'cardChatBot': Color(0xFFFFFFFF),
      'messageUserBackground': Color(0xFFD98A19),
      'messageBotBackground': Color(0xFFF6810A),
      'headerBackground': Color(0xFFF5B000),
      'headerCircle1': Color(0xFFFFE082),
      'headerCircle2': Color(0xFFFFD54F),
      'headerCircle3': Color(0xFFFFC107),
      'primaryText': Colors.black,
      'secondaryText': Colors.black87,
      'chatBubbleBackground': Colors.amber,
      'footerBackground': Colors.amber,
    },
  };

  static Color getColor(int themeIndex, String colorKey) {
    return themes[themeIndex]?[colorKey] ?? Colors.black;
  }
}
