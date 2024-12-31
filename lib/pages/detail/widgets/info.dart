import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/models/game.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/description.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/gallery.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/header.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/review.dart';

class GameInfo extends StatelessWidget {
  final Game game;

  const GameInfo(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          HeaderSection(game),
          GallerySection(game),
          DescriptionSection(game),
          ReviewSection(game)
        ],
      ),
    );
  }
}
