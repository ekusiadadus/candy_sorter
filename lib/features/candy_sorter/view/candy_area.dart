import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:flutter/material.dart';

import '../widgets/candy_widget.dart';

class CandyArea extends StatefulWidget {
  const CandyArea({
    Key? key,
    required this.game,
    required this.onRemoveCandy,
    required this.onAddTwoLeft,
  }) : super(key: key);

  final Game game;
  final Function onRemoveCandy;
  final Function onAddTwoLeft;

  @override
  State<CandyArea> createState() => _CandyAreaState();
}

class _CandyAreaState extends State<CandyArea> {
  Offset _beginCandyOffset = const Offset(0, 0);

  _buildStack(BoxConstraints constraints) {
    List<Widget> list = [];
    for (var candy in widget.game.candies) {
      list.add(
        AnimatedPositioned(
          top: candy.top,
          left: candy.left,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 250),
          child: Draggable<Candy>(
            data: candy,
            feedback: CandyWidget(
              candy: candy,
            ),
            child: CandyWidget(
              candy: candy,
            ),
            childWhenDragging: Container(),
            onDragCompleted: () {
              widget.onRemoveCandy(candy);
            },
            onDragStarted: () {
              setState(() {
                _beginCandyOffset = Offset(candy.left, candy.top);
              });
            },
            onDragUpdate: (details) {
              setState(() {
                candy.left = details.localPosition.dx;
                candy.top = details.localPosition.dy - 120;
              });
            },
            onDragEnd: (DraggableDetails details) {
              if (!details.wasAccepted) {
                widget.onAddTwoLeft();
                widget.game.addTwo();
                setState(() {
                  candy.left = _beginCandyOffset.dx;
                  candy.top = _beginCandyOffset.dy;
                });
              }
              print('onDragEnd - accepted: ${details.wasAccepted}');
            },
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(
          clipBehavior: Clip.none,
          children: _buildStack(constrains),
        );
      },
    );
  }
}
