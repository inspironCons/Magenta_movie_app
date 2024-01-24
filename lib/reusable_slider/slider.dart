import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget sliderList(List listname, String title, String type, int itemcount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 20),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 470,
        // color: Colors.amber,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemcount,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
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
                                "https://image.tmdb.org/t/p/w500${listname[index]['poster_path']}",
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
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              listname[index]['name'],
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
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              listname[index]['Date'],
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
                                color: Colors.white,
                                fontSize: 12,
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
                        ))
                  ],
                ),
              );
            })),
      ),
      
    ],
  );
}