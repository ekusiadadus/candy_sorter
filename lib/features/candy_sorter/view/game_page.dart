import 'dart:async';

import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/providers/settings_provider.dart';
import 'package:candy_sorter/features/candy_sorter/view/won.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'bowl_area.dart';
import 'candy_area.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  late Game game;
  Timer? timer;
  int seconds = 0;
  bool won = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createGame();
  }

  _createGame() {
    ref.read(gameSettingsProvider).loadSettings();
    final colors = ref.read(gameSettingsProvider).colors;
    final candies = ref.read(gameSettingsProvider).numberOfCandies;
    setState(() {
      won = false;
      game = Game(
        colors: colors,
        numberOfCandies: candies,
        gameArea: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 2,
        ),
      );
    });
    initTimer();
  }

  void initTimer() {
    seconds = 0;
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), (_) => seconds++);
  }

  /// Call this when you put a candy into the bowl.
  void _onRemoveCandy(Candy candy) {
    ref.read(gameSettingsProvider).colorDragged = candy.color;
    ref.read(gameSettingsProvider).incrementSorted(candy.color);
    setState(() {
      game.removeCandy(candy);
      if (game.candies.isEmpty) {
        timer?.cancel();
        won = true;
      }
    });
  }

  void _addTwoCandies() {
    setState(() {
      ref.read(gameSettingsProvider).addTwoLeft();
    });
  }

  @override
  Widget build(BuildContext context) {
    final leftCandies = ref.watch(gameSettingsProvider).left;
    final sortedCandies = ref.watch(gameSettingsProvider).sorted;
    double waveHeight = 0.05;
    final width = MediaQuery.of(context).size.width;
    if (leftCandies > 0 && sortedCandies > 0) {
      waveHeight = sortedCandies / (leftCandies + sortedCandies);
      print(waveHeight);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candy Sorter'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            onPressed: () {
              _createGame();
            },
            icon: const Icon(Icons.replay),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Candies left: $leftCandies',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Candies sorted: $sortedCandies',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          won
              ? Expanded(
                  child: Won(
                    seconds: seconds,
                  ),
                )
              : Container(),
          !won
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: CandyArea(
                    onAddTwoLeft: _addTwoCandies,
                    onRemoveCandy: _onRemoveCandy,
                    game: game,
                  ),
                )
              : Container(),
          !won
              ? Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return BowlArea(
                        game: game,
                        constraints: constraints,
                      );
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 15.0,
            width: width,
            child: LiquidLinearProgressIndicator(
                value: waveHeight,
                borderRadius: 5.0, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors.blue
                    .shade100), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white, // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.transparent,
                borderWidth: 1.0,
                direction: Axis
                    .horizontal // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical,
                ),
          ),
        ],
      ),
    );
  }
}
