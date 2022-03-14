import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String candiesCount = "candies";
  static const String colorsList = "colors";
  final SharedPreferences prefs;

  SharedPreferenceHelper({required this.prefs});

  setCandies({required int candies}) async {
    await prefs.setInt(candiesCount, candies);
  }

  int get candies => prefs.getInt(candiesCount) ?? 20;

  setColors({required List<Color> colors}) async {
    final List<String> list = [];
    for (var i = 0; i < colors.length; i++) {
      list.add(colors[i].value.toString());
    }
    await prefs.setStringList(colorsList, list);
  }

  List<Color> get colors {
    final list = prefs.getStringList(colorsList);
    List<Color> result = [];
    if (list != null && list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        result.add(Color(int.parse(list[i])).withOpacity(1));
      }
    } else {
      result = [
        Colors.red,
        Colors.green,
        Colors.blueGrey,
        Colors.cyan,
        Colors.orange,
      ];
    }
    return result;
  }
}
