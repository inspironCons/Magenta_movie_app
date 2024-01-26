import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/apikey/apikey.dart';
import 'package:moviesapp/reusable_slider/slider_upcoming.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Map<String, dynamic>> upcomingmoviesseries = [];
  var upcomingmoviesurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey';

  Future<void> upcomingmovies() async {
    var upcomingmoviesresponse = await http.get(Uri.parse(upcomingmoviesurl));
    if (upcomingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(upcomingmoviesresponse.body);
      var upcomingmoviesjson = tempdata['results'];
      for (var i = 0; i < upcomingmoviesjson.length; i++) {
        upcomingmoviesseries.add({
          "title": upcomingmoviesjson[i]["title"],
          "poster_path": upcomingmoviesjson[i]["poster_path"],
          "vote_average": upcomingmoviesjson[i]["vote_average"],
          "release_date": upcomingmoviesjson[i]["release_date"],
          "id": upcomingmoviesjson[i]["id"],
        });
      }
    } else {
      print(upcomingmoviesresponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: upcomingmovies(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff12cdd9),
              ),
            );
          } else {
            return SingleChildScrollView(
                child: Column(
              children: [
                sliderListUpcoming(
                    upcomingmoviesseries, 'Upcoming Movies', 'Upcoming', 20)
              ],
            ));
          }
        }));
  }
}
