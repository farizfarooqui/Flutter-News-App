import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/view/detail_screen.dart';
import 'package:news_app/viewModel/news_view_model.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

NewsViewModel newsViewModel = NewsViewModel();

class _CategoryScreenState extends State<CategoryScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  String selectedCategory = 'general';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 245, 5, 5),
        title: Text(
          'Categories',
          style: GoogleFonts.aDLaMDisplay(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
          future: newsViewModel.fetchNewsCategoryApi(selectedCategory),
          builder: (context, snaphot) {
            if (snaphot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: SpinKitDualRing(
                    color: Colors.redAccent,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snaphot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                        snaphot.data!.articles![index].publishedAt.toString());
                    return SizedBox(
                        height: height * 0.25,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              sourceName: snaphot.data!
                                                  .articles![index].source!.name
                                                  .toString(),
                                              author: snaphot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              title: snaphot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              description: snaphot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              urlToImage: snaphot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              publishedAt: snaphot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              content: snaphot.data!
                                                  .articles![index].content
                                                  .toString(),
                                              newsUrl: snaphot
                                                  .data!.articles![index].url
                                                  .toString(),
                                            )));
                              },
                              child: Container(
                                color: const Color.fromARGB(31, 253, 101, 101),
                                child: Stack(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: height * 0.25,
                                          width: width * 0.30,
                                          child: CachedNetworkImage(
                                            imageUrl: snaphot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: SizedBox(
                                            height: height * 0.20,
                                            width: width * 0.62,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snaphot.data!.articles![index]
                                                      .title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.aBeeZee(
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    snaphot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 20,
                                                    style: GoogleFonts.adamina(
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: width * 0.30,
                                        color: Colors.white70,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              snaphot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.aBeeZee(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 2,
                                      child: Center(
                                        child: Text(
                                          format.format(dateTime),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            }
          }),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: const Color.fromARGB(255, 245, 5, 5),
        barItems: [
          BarItem(title: 'General', icon: Icons.apps),
          BarItem(title: 'Health', icon: Icons.health_and_safety_rounded),
          BarItem(title: 'Sports', icon: Icons.sports),
          BarItem(title: 'Business', icon: Icons.business_sharp)
        ],
        selectedIndex: selectedIndex,
        onButtonPressed: (int index) {
          setState(() {
            switch (index) {
              case 0:
                selectedCategory = 'general';
                selectedIndex = 0;
                break;
              case 1:
                selectedCategory = 'health';
                selectedIndex = 1;

                break;
              case 2:
                selectedCategory = 'sports';
                selectedIndex = 2;
                break;
              case 3:
                selectedCategory = 'business';
                selectedIndex = 3;
                break;
            }
          });
        },
        activeColor: Colors.white,
      ),
    );
  }
}
