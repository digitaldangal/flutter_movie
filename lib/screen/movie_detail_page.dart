import 'package:flutter/material.dart';

import 'package:flutter_movie_app/model/movies.dart';

import 'package:flutter_movie_app/widget/poster.dart';
import 'package:flutter_movie_app/widget/stars_rating.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage(this.movie);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: new Stack(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new _MovieDetailHeader(movie),
                  _buildStoryLine(theme),
                  _buildPhotosSection(theme),
                  _buildActorsSection(theme),
                ],
              ),
              _buildButtonBack(context),
            ],
          ),

        ),
      ),
    );
  }

  _buildButtonBack(BuildContext context){
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: new Padding(
        padding: new EdgeInsets.only(top: statusBarHeight + 8.0, left: 16.0),
        child: new Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildStoryLine(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Story line',
            style: theme.textTheme.subhead.copyWith(fontSize: 18.0),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 8.0),
          ),
          new Text(
            movie.storyline,
            style: theme.textTheme.body1
                .copyWith(color: Colors.black45, fontSize: 16.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(
                'more',
                style: theme.textTheme.body1
                    .copyWith(fontSize: 16.0, color: theme.accentColor),
              ),
              new Icon(
                Icons.arrow_drop_down,
                color: theme.accentColor,
              )
            ],
          )
        ],
      ),
    );
  }

  _buildPhotosSection(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Photos',
            style: theme.textTheme.subhead.copyWith(fontSize: 18.0),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(100.0),
            child: new ListView.builder(
              itemBuilder: _buildPhoto,
              itemCount: movie.photoUrls.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  _buildPhoto(BuildContext context, int index) {
    var photo = movie.photoUrls[index];

    return new Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: new ClipRRect(
        borderRadius: new BorderRadius.circular(4.0),
        child: new Image.asset(
          photo,
          width: 160.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildActorsSection(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Actors',
            style: theme.textTheme.subhead.copyWith(fontSize: 18.0),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(120.0),
            child: new ListView.builder(
              itemBuilder: _buildActor,
              itemCount: movie.actors.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  _buildActor(BuildContext context, int index) {
    var actor = movie.actors[index];

    return new Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: new Column(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: new AssetImage(actor.avatarUrl),
            radius: 40.0,
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
          ),
          new Text(actor.name),
        ],
      ),
    );
  }
}

class _MovieDetailHeader extends StatelessWidget {
  final Movie movie;

  _MovieDetailHeader(this.movie);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          movie.title,
          style: textTheme.title,
        ),
        new _RatingInformation(movie),
        new Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: new Row(
            children: _buildMovieCategory(textTheme),
          ),
        ),
      ],
    );

    return new Stack(
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: new _ArcBannerImage(movie.bannerUrl)),
        new Positioned(
          bottom: 0.0,
          left: 14.0,
          right: 14.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Poster(
                movie.posterUrl,
                height: 180.0,
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildMovieCategory(TextTheme textTheme) {
    return movie.categories.map((category) {
      return new Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: new Chip(
          label: new Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }
}

class _ArcBannerImage extends StatelessWidget {
  final String imageUrl;

  _ArcBannerImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new _BottomArcClipper(),
      child: new Image.asset(
        imageUrl,
        height: 230.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    var firstControlPoint = new Offset(size.width / 4, size.height);
    var firstEndPoint = new Offset(size.width / 2, size.height);
    var secondControlPoint = new Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = new Offset(size.width, size.height - 30);

    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _RatingInformation extends StatelessWidget {
  final Movie movie;

  _RatingInformation(this.movie);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numberRating = new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          movie.rating.toString(),
          style: textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Text(
            'Ratings',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    var starsRating = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new StarsRating(movie.starRating),
        new Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: new Text(
              'Grade now',
              style: ratingCaptionStyle,
            ))
      ],
    );

    return new Row(
      children: <Widget>[
        numberRating,
        new Padding(
            padding: const EdgeInsets.only(left: 16.0), child: starsRating),
      ],
    );
  }
}
