import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/apikey/apikey.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularmoviesseries = [];

  var popularmoviesurl =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';

  Future<void> moviesfunction() async {
    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'];
      for (var i = 0; i < popularmoviesjson.length; i++) {
        popularmoviesseries.add({
          "title": popularmoviesjson[i]["title"],
          "poster_path": popularmoviesjson[i]["poster_path"],
          "vote_average": popularmoviesjson[i]["vote_average"],
          "release_date": popularmoviesjson[i]["release_date"],
          "id": popularmoviesjson[i]["id"],
        });
      }
    } else {
      print(popularmoviesresponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: moviesfunction(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff12cdd9)),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 20),
                  child: Text(
                    'Popular Movies',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 470,
                  // color: Colors.amber,
                  child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: popularmoviesseries.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: SingleChildScrollView(
                            // controller: ScrollController(),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 300,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500${popularmoviesseries[index]['poster_path']}",
                                          ))),
                                ),
                                Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xff252836),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, bottom: 10),
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Movie Title',
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff92929D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          popularmoviesseries[index]['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Date Release',
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff92929D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          popularmoviesseries[index]
                                              ['release_date'],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Rating',
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff92929D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '⭐ ${popularmoviesseries[index]['vote_average']}',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      })),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
