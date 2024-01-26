import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  var movieid;

   MovieDetails(this.movieid);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
