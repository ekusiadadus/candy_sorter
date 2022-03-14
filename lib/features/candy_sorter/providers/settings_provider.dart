import 'dart:core';

import 'package:candy_sorter/features/candy_sorter/services/locator.dart';
import 'package:candy_sorter/features/candy_sorter/shared_prefs/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class GameSettings {
  GameSettings();
  int sorted = 0;
  int left = 0;
  Color? colorDragged;

  late int _numberOfCandies = 20;
  late List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    Colors.cyan,
    Colors.orange,
  ];

  void incrementSorted(Color color) {
    sorted++;
    left = _numberOfCandies - sorted;
  }

  void addTwoLeft() {
    print('settings - addtwoleft....');
    _numberOfCandies = _numberOfCandies + 2;
    left = _numberOfCandies - sorted;
  }

  set numberOfCandies(int value) {
    getIt<SharedPreferenceHelper>().setCandies(candies: value);
    _numberOfCandies = value;
  }

  set colors(List<Color> value) {
    getIt<SharedPreferenceHelper>().setColors(colors: value);
    _colors = value;
  }

  int get numberOfCandies {
    return getIt<SharedPreferenceHelper>().candies;
  }

  List<Color> get colors {
    return GetIt.instance<SharedPreferenceHelper>().colors;
  }

  loadSettings() async {
    _colors = getIt<SharedPreferenceHelper>().colors;
    _numberOfCandies = getIt<SharedPreferenceHelper>().candies;
    left = _numberOfCandies;
    sorted = 0;
  }
}

final gameSettingsProvider =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
        (ref) => GameSettingsNotifier());

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(GameSettings());
}
