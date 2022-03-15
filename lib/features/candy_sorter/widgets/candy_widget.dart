import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/colored_svg.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CandyWidget extends StatelessWidget {
  const CandyWidget({
    Key? key,
    required this.candy,
    this.width = cCandyWidth,
  }) : super(key: key);

  final Candy candy;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ColoredSvg(
      path: 'assets/candy.svg',
      color: candy.color,
      width: width,
    );
  }
}
