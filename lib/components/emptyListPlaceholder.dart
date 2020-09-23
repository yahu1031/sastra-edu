import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/lottieAnimations.dart';

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
              widthFactor: .9,
              child: AspectRatio(
                aspectRatio: 1,
                child: Lottie.asset(
                  text.contains('favorite')
                      ? LottieAnimations.kFavorite
                      : text.contains('bookmark')
                          ? LottieAnimations.kBookmark
                          : LottieAnimations.bookLoading,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'You are so close to adding $text 😉',
            style: headline4TextStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
