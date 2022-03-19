import 'dart:math';

import 'package:candy_sorter/features/candy_sorter/view/game_page_content.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final random = Random();
  @override
  Widget build(BuildContext context) {
    final double dx = random.nextDouble();
    final double dy = random.nextDouble();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              child: const GamePageContent(),
              builder: (BuildContext context, double value, Widget? child) {
                return ShaderMask(
                  child: const GamePageContent(),
                  shaderCallback: (rect) {
                    return RadialGradient(
                      radius: value * 5,
                      colors: const [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        Colors.transparent
                      ],
                      stops: const [0.0, 0.55, 0.6, 1.0],
                      center: FractionalOffset(dx, dy),
                    ).createShader(rect);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
