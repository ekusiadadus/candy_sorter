import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colored_svg.dart';

class Bowl extends ConsumerStatefulWidget {
  const Bowl({
    Key? key,
    this.color = Colors.black,
    this.width = 130,
  }) : super(key: key);

  final Color color;
  final double width;

  @override
  ConsumerState<Bowl> createState() => _BowlState();
}

class _BowlState extends ConsumerState<Bowl> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: widget.width,
        height: 80,
        child: Stack(
          children: [
            ColoredSvg(
              path: 'assets/bowl.svg',
              color: widget.color,
              width: widget.width,
            ),
          ],
        ),
      ),
    );
  }
}
