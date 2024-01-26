import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/apilinks/allapi.dart';
import 'package:moviesapp/home/widget/movies.dart';
import 'package:moviesapp/home/widget/tvseries.dart';
import 'package:moviesapp/home/widget/upcoming.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trendinglist = [];

  Future<void> trendinglistHome() async {
    if (uval == 1) {
      var trendingweekresponse = await http.get(Uri.parse(trendingweekurl));
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendinglist.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else if (uval == 2) {
      var trendingdayresponse = await http.get(Uri.parse(trendingdayurl));
      if (trendingdayresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingdayresponse.body);
        var trendingweekjson = tempdata['results'];
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendinglist.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else {}
  }

  int uval = 1;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: const Color(0xff1f1d2b),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: true,
            toolbarHeight: 60,
            pinned: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                  future: trendinglistHome(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          height: MediaQuery.of(context).size.height,
                        ),
                        items: trendinglist.map((i) {
                          return Builder(builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${i['poster_path']}'),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff12cdd9),
                        ),
                      );
                    }
                  }),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trending' '🔥',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 45,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DropdownButton(
                      value: uval,
                      onChanged: (value) {
                        setState(() {
                          trendinglist.clear();
                          uval = int.parse(value.toString());
                        });
                      },
                      autofocus: true,
                      underline:
                          Container(height: 0, color: Colors.transparent),
                      dropdownColor: Colors.black.withOpacity(0.6),
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Color(0xff12cdd9),
                        size: 30,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Weekly',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Daily',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                      dividerHeight: 0,
                      indicatorPadding: const EdgeInsets.only(
                          top: 1, bottom: 1, left: -20, right: -20),
                      indicator: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          color: const Color(0xff252836),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                      isScrollable: true,
                      indicatorColor: const Color(0xff12cdd9),
                      labelColor: const Color(0xff12cdd9),
                      tabs: [
                        Tab(
                          child: Text(
                            'Tv Series',
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text('Movies',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Tab(
                          child: Text('Upcoming',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      Tvseries(),
                      Movies(),
                      Upcoming(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
