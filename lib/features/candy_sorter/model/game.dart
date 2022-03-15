import 'dart:math';

import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Game {
  Game({
    required this.colors,
    required this.numberOfCandies,
    this.gameArea = const Size(0, 0),
  }) {
    _fillCandies();
  }

  final int numberOfCandies;

  final List<Color> colors;
  final List<Candy> candies = [];
  final Size gameArea;

  void removeCandy(Candy candy) {
    candies.remove(candy);
  }

  _getNewCandy() {
    final random = Random();
    int nextIndex = random.nextInt(colors.length);
    return Candy(
      color: colors[nextIndex],
      top: random
          .nextInt(gameArea.height.toInt() - cMaxAppBarHeight.toInt())
          .toDouble(),
      left: random
          .nextInt(gameArea.width.toInt() - cCandyWidth.toInt() - 20)
          .toDouble(),
    );
  }

  void _fillCandies() {
    for (var i = 0; i < numberOfCandies; i++) {
      candies.add(_getNewCandy());
    }
  }

  void addTwo() {
    for (var i = 0; i < 2; i++) {
      candies.add(_getNewCandy());
    }
  }
}
