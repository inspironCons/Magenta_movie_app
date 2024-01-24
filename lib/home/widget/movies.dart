import 'package:flutter/material.dart';
import 'package:moviesapp/apikey/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
  
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> populartvseries = [];
  var populartvseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';

  Future<void> tvseriesfunction() async {
    var populartvresponse = await http.get(Uri.parse(populartvseriesurl));
    if (populartvresponse.statusCode == 200) {
      var tempdata = jsonDecode(populartvresponse.body);
      var populartvjson = tempdata['results'];
      for (var i = 0; i < populartvjson.length; i++) {
        populartvseries.add({
          "name": populartvjson[i]["name"],
          "poster_path": populartvjson[i]["poster_path"],
          "vote_average": populartvjson[i]["vote_average"],
          "Date": populartvjson[i]["first_air_date"],
          "id": populartvjson[i]["id"],
        });
      }
    } else {
      print(populartvresponse.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Movies'),
      ),
    );
  }
}