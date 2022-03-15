import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
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
  bool isAccepted = false;

  _buildStack(BoxConstraints constraints) {
    List<Widget> list = [];
    for (var candy in widget.game.candies) {
      list.add(
        AnimatedPositioned(
          top: candy.top,
          left: candy.left,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCirc,
          child: Draggable<Candy>(
            data: candy,
            feedback: CandyWidget(
              candy: candy,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: candy.dragged ? 0 : 1,
              child: CandyWidget(
                candy: candy,
              ),
            ),
            childWhenDragging: Container(),
            onDragCompleted: () {
              if (isAccepted) {
                widget.onRemoveCandy(candy);
                setState(() {
                  isAccepted = false;
                });
              }
            },
            onDragStarted: () {
              setState(() {
                _beginCandyOffset = Offset(candy.left, candy.top);
                candy.dragged = true;
              });
            },
            onDragUpdate: (details) {
              setState(() {
                candy.left = details.localPosition.dx - 20;
                candy.top = details.localPosition.dy - 180;
              });
            },
            onDragEnd: (DraggableDetails details) {
              if (!details.wasAccepted) {
                if (details.offset.dy - cMaxAppBarHeight >=
                    constraints.maxHeight) {
                  widget.onAddTwoLeft();
                  widget.game.addTwo();
                }
                setState(() {
                  candy.left = _beginCandyOffset.dx;
                  candy.top = _beginCandyOffset.dy;
                  isAccepted = false;
                  candy.dragged = false;
                });
              } else {
                setState(() {
                  isAccepted = true;
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
