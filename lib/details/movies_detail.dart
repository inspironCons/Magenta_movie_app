import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/apikey/apikey.dart';
import 'package:moviesapp/home/home.dart';

class MoviesDetails extends StatefulWidget {
  var id;

  MoviesDetails(this.id, {super.key});

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> Similiarmovieslist = [];
  List<Map<String, dynamic>> Recommendationmovielist = [];
  List<Map<String, dynamic>> Movietrailerlist = [];

  List<Map<String, dynamic>> Moviesgenres = [];

  Future<void> MoviesDetails() async {
    var moviedetailurl =
        'https://api.themoviedb.org/3/movie/${widget.id.toString()}?api_key=$apikey';
    var userreviewurl =
        'https://api.themoviedb.org/3/movie/${widget.id.toString()}/reviews?api_key=$apikey';
    var similiarmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget.id.toString()}/similiar?api_key=$apikey';
    var recommendedmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget.id.toString()}/recommendations?api_key=$apikey';
    var moviestrailerurl =
        'https://api.themoviedb.org/3/movie/${widget.id.toString()}/videos?api_key=$apikey';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        MovieDetails.add({
          'backdrop_path': moviedetailjson['backdrop_path'],
          'title': moviedetailjson['title'],
          'vote_average': moviedetailjson['vote_average'],
          'overview': moviedetailjson['overview'],
          'release_date': moviedetailjson['release_date'],
          'runtime': moviedetailjson['runtime'],
          'budget': moviedetailjson['budget'],
          'revenue': moviedetailjson['revenue'],
        });
      }
      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        Moviesgenres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {}

    var UserReviewresponse = await http.get(Uri.parse(userreviewurl));
    if (UserReviewresponse.statusCode == 200) {
      var UserReviewjson = jsonDecode(UserReviewresponse.body);
      for (var i = 0; i < UserReviewjson['results'].length; i++) {
        UserReviews.add({
          'name': UserReviewjson['results'][i]['author'],
          'review': UserReviewjson['results'][i]['content'],
          'rating': UserReviewjson['results'][i]['author_details']['rating'] ==
                  null
              ? "Not Rated"
              : UserReviewjson['results'][i]['author_details']['avatar_path'] ==
                      null
                  ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                  : 'https://image.tmdb.org/t/p/w500' +
                      UserReviewjson['results'][i]['created_at']
                          .substring(0, 10),
          'fullreviewurl': UserReviewjson['results'][i]['url'],
        });
      }
    } else {}

    var similiarmoviesresponse = await http.get(Uri.parse(similiarmoviesurl));
    if (similiarmoviesresponse.statusCode == 200) {
      var similiarmoviesjson = jsonDecode(similiarmoviesresponse.body);
      for (var i = 0; i < similiarmoviesjson['results'].length; i++) {
        Similiarmovieslist.add({
          'poster_path': similiarmoviesjson['results'][i]['poster_path'],
          'name': similiarmoviesjson['results'][i]['title'],
          'vote_average': similiarmoviesjson['results'][i]['vote_average'],
          'Date': similiarmoviesjson['results'][i]['release_date'],
          'id': similiarmoviesjson['results'][i]['id'],
        });
      }
    } else {}

    var recommendationmoviesresponse =
        await http.get(Uri.parse(recommendedmoviesurl));
    if (recommendationmoviesresponse.statusCode == 200) {
      var recommendedmoviesjson = jsonDecode(recommendationmoviesresponse.body);
      for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
        Recommendationmovielist.add({
          'poster_path': recommendedmoviesjson['results'][i]['poster_path'],
          'name': recommendedmoviesjson['results'][i]['title'],
          'vote_average': recommendedmoviesjson['results'][i]['vote_average'],
          'Date': recommendedmoviesjson['results'][i]['release_date'],
          'id': recommendedmoviesjson['results'][i]['id'],
        });
      }
    } else {}
    var movietrailerresponse = await http.get(Uri.parse(moviestrailerurl));
    if (movietrailerresponse.statusCode == 200) {
      var movietrailerjson = jsonDecode(movietrailerresponse.body);
      for (var i = 0; i < movietrailerjson['results'].length; i++) {
        if (movietrailerjson['results'][i]['type'] == 'Trailer') {
          Movietrailerlist.add({
            'key': movietrailerjson['results'][i]['key'],
          });
        }
      }
      Movietrailerlist.add({'key': 'aJ0cZTcTh90'});
    } else {}
    print(Movietrailerlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1d2b),
      // body: FutureBuilder(
      //     future: MoviesDetails(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return CustomScrollView(
      //           physics: const BouncingScrollPhysics(),
      //           slivers: [
      //             SliverAppBar(
      //               automaticallyImplyLeading: false,
      //               leading: IconButton(
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                   icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28,)),
      //                   actions: [

      //                     IconButton(
      //                       onPressed: () {
      //                         Navigator.pushAndRemoveUntil(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => const Home()),
      //                               (route) => false);
      //                       }, 
      //                       icon: const Icon(Icons.home, size: 28, color: Colors.white,))
      //                   ],
      //                   backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
      //                   centerTitle: false,
      //                   pinned: true,
      //                   expandedHeight: MediaQuery.of(context).size.height * 0.4,
      //                   flexibleSpace: const FlexibleSpaceBar(
      //                     collapseMode: CollapseMode.parallax,
      //                     background: FittedBox(
      //                       fit: BoxFit.fill,
      //                       child: trailewatch(
      //                         trailerytid: Movietrailerlist[0]['key'],
      //                       ),
      //                     ),
      //                   ),
      //             )
      //           ],
      //         );
      //       } else {}
      //     }),
    );
  }
}
