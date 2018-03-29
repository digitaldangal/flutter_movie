import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget{
  final int rating;

  StarsRating(this.rating);

  @override
  Widget build(BuildContext context) {
    var stars = <Widget>[];

    for (int i = 1; i <= 5; i++) {
      var star = new Icon(
        Icons.star,
        color: i <= rating ? Colors.red : Colors.black12,
        size: 12.0,
      );
      stars.add(star);
    }

    return new Row(
      children: stars,
    );
  }
}