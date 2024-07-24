// lib/src/utils/basic_utils.dart
import 'package:color_type_converter/exports.dart';

void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) => debugPrint(match.group(0)));
}