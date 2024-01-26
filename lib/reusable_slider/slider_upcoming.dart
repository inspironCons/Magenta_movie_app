import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget sliderListUpcoming(
    List listname, String title, String type, int itemcount) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: itemcount,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 170,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500${listname[index]['poster_path']}",
                                  ))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xff252836),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              padding: const EdgeInsets.only(
                                // top: 10,
                                left: 10,
                              ),
                              height: 170,
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Movie Title',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xff92929D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    listname[index]['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  Text(
                                    'Date Release',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xff92929D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    listname[index]['release_date'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // const SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  Text(
                                    'Rating',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xff92929D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '⭐ ${listname[index]['vote_average']}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    ),
  );
}
