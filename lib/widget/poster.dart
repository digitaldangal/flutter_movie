import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const double POSTER_RATIO = 0.7;
  final String imageUrl;
  final double height;

  Poster(this.imageUrl, {this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    final width = height * POSTER_RATIO;

    return new Material(
      borderRadius: new BorderRadius.circular(4.0),
      elevation: 2.0,
      child: new Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}