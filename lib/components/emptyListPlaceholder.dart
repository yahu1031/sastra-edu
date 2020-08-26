import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/images.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final String text;

  const EmptyListPlaceholder(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimensions.largePadding,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.extraLargePadding),
            child: FractionallySizedBox(
              widthFactor: .6,
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(Images.highFive),
              ),
            ),
          ),
          Text(
            'You are so close to adding $text ;)',
            style: headline4TextStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
