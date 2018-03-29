import 'package:flutter/material.dart';

import 'package:flutter_movie_app/model/movies.dart';

import 'package:flutter_movie_app/screen/movie_detail_page.dart';
import 'package:flutter_movie_app/widget/poster.dart';
import 'package:flutter_movie_app/widget/stars_rating.dart';

class MainPage extends StatelessWidget {
  final List<Movie> movies = <Movie>[
    testMovie,
    testMovie,
    testMovie,
    testMovie,
    testMovie,
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xFFE4E6E7),
      body: new Column(
        children: <Widget>[
          new _MainAppBar('MOVIE'),
          _buildVerticalSeparator(),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  _buildFeatureReview(),
                  new _MoviesSection(
                    title: "Popular",
                    movies: movies,
                  ),
                  new _MoviesSection(
                    title: "Top100",
                    movies: movies,
                  ),
                  new Container(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildVerticalSeparator() {
    return new Container(
      height: 0.5,
      decoration: new BoxDecoration(color: Colors.black26),
    );
  }

  _buildFeatureReview() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMovieInfo(),
        new Expanded(
          child: new Container(
            height: 150.0,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: _buildComment(),
          ),
        )
      ],
    );
  }

  _buildMovieInfo() {
    return new Stack(
      children: <Widget>[
        new Image.asset(
          'assets/images/heidi.jpg',
          fit: BoxFit.cover,
          width: 220.0,
          height: 150.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Heidi',
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              new Container(
                height: 4.0,
              ),
              new Text(
                'German/Switzerland',
                style: const TextStyle(color: Colors.white, fontSize: 12.0),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildComment() {
    final String comment = 'Not everybody knows Heidi. People are taking about '
        'their favourite versions, but for me this is the first film and I '
        'loved it. Now I\'m not going to watch the other versions, because I '
        'think nothing would surpass this one. I\'ll stand by my statement till'
        ' someone convince me over. This is definitely the Swiss version of '
        '\'The Secret Garden\', except the garden is so big and not a secret. '
        'Hailing from a Himalayan nation, I do love the Alps more for its beauty'
        ' than the snowy and rocky Himalayas. Last month I saw another film '
        'theme related to the Alps called \'Brothers of Wind\'. So lately I\'ve '
        'been watching some fine films, pure children\'s films where adults'
        ' toocan have a great time.';

    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new CircleAvatar(
                backgroundImage:
                    new AssetImage('assets/images/review_user_avatar.jpg'),
                radius: 16.0,
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Rona'),
                    new Row(
                      children: <Widget>[
                        new StarsRating(4),
                        new Container(
                          margin: const EdgeInsets.only(left: 4.0),
                        ),
                        new Text(
                          '8.4',
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12.0),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          new Text(
            comment,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black45, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

class _MainAppBar extends StatelessWidget {
  static const double APP_BAR_HEIGHT = 60.0;

  final String title;

  _MainAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + APP_BAR_HEIGHT,
      child: new Container(
        decoration: new BoxDecoration(
          color: const Color(0xFFF9F9F9),
        ),
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new Text(
                'MOVIE',
                style: const TextStyle(
                  fontFamily: 'CallOfOpsDuty',
                  color: Colors.black,
                  fontSize: 36.0,
                ),
              ),
            ),
            new Align(
              child: new Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: new Icon(
                    Icons.search,
                    size: 35.0,
                  )),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}

class _MoviesSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  _MoviesSection({this.title, this.movies});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: new BoxDecoration(color: Colors.white),
      child: new Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              title,
              style: const TextStyle(fontSize: 18.0),
            ),
            new Container(
              height: 8.0,
            ),
            new SizedBox.fromSize(
              size: new Size.fromHeight(250.0),
              child: new ListView.builder(
                itemBuilder: _buildMovie,
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMovie(BuildContext context, int index) {
    Movie movie = movies[index];

    return new GestureDetector(
      onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (_) => new MovieDetailsPage(movie),
            ),
          ),
      child: new Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: new Container(
          width: 140.0,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Poster(
                movie.posterUrl,
                height: 200.0,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Ratings: ',
                      style: new TextStyle(color: Colors.black54),
                    ),
                    new Text(
                      movie.rating.toString(),
                      style: new TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
