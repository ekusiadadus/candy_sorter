import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BowlArea extends StatelessWidget {
  const BowlArea({
    Key? key,
    required this.game,
    required this.constraints,
  }) : super(key: key);

  final Game game;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final width = constraints.maxWidth / game.colors.length;
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 5.0,
      spacing: 5.0,
      runAlignment: WrapAlignment.center,
      children: [
        for (var i = 0; i < game.colors.length; i++)
          DragTarget<Candy>(
            builder: (BuildContext context, List<dynamic> accepted,
                List<dynamic> rejected) {
              return Bowl(
                color: game.colors[i],
                width: width,
              );
            },
            onWillAccept: (Candy? data) {
              print('onWillAccept: ${data?.color == game.colors[i]}');
              return data?.color == game.colors[i];
            },
          ),
      ],
    );
  }
}
