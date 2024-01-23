import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/newchannel_headlines.dart';
import 'package:news_app/models/news_tech_headlines.dart';
import 'package:news_app/view/category_screen.dart';
import 'package:news_app/view/detail_screen.dart';
import 'package:news_app/viewModel/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum FilterName { bbcnews, abcnews, arynews, cnn, reuters }

class _HomeViewState extends State<HomeView> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String selectedChannel = 'bbc-news'; // Default channel

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  (MaterialPageRoute(builder: (_) => const CategoryScreen())));
            },
            icon: const Icon(
              Icons.apps_rounded,
              color: Colors.white,
              size: 30,
            )),
        backgroundColor: const Color.fromARGB(255, 245, 5, 5),
        title: Center(
          child: Text(
            'News App',
            style: GoogleFonts.aDLaMDisplay(color: Colors.white, fontSize: 30),
          ),
        ),
        actions: [
          PopupMenuButton<FilterName>(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
            ),
            onSelected: (FilterName channel) {
              setState(() {
                // Update the selected channel based on the menu item selected
                switch (channel) {
                  case FilterName.bbcnews:
                    selectedChannel = 'bbc-news';
                    break;
                  case FilterName.abcnews:
                    selectedChannel = 'abc-news';
                    break;
                  case FilterName.arynews:
                    selectedChannel = 'ary-news';
                    break;
                  case FilterName.cnn:
                    selectedChannel = 'cnn';
                  case FilterName.reuters:
                    selectedChannel = 'reuters';
                }
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterName>>[
              const PopupMenuItem(
                value: FilterName.bbcnews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem(
                value: FilterName.abcnews,
                child: Text('ABC News'),
              ),
              const PopupMenuItem(
                value: FilterName.arynews,
                child: Text('ARY News'),
              ),
              const PopupMenuItem(
                value: FilterName.cnn,
                child: Text('CNN News'),
              ),
              const PopupMenuItem(
                value: FilterName.reuters,
                child: Text('Reuters News'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.6,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future:
                  newsViewModel.fetchNewsChannelHeadlineApi(selectedChannel),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitDualRing(
                      color: Colors.redAccent,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('$e'));
                } else if (snapshot.data == null ||
                    snapshot.data!.articles == null) {
                  return const Text('No data available');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.articles![index];
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return SizedBox(
                        height: height,
                        width: width * 0.90,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            sourceName: snapshot.data!
                                                .articles![index].source!.name
                                                .toString(),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            title: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            description: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            urlToImage: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            publishedAt: snapshot.data!
                                                .articles![index].publishedAt
                                                .toString(),
                                            content: snapshot
                                                .data!.articles![index].content
                                                .toString(),
                                            newsUrl: snapshot
                                                .data!.articles![index].url
                                                .toString(),
                                          )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: height,
                                    width: width,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    left: 10,
                                    child: Card(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Text(
                                              data.title.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.aBeeZee(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.source!.name.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.aBeeZee(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.blue,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.aBeeZee(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  'All About Tech',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                )
              ],
            ),
          ),
          FutureBuilder<NewsTechHeadlinesModel>(
              future: newsViewModel.fetchNewsTechHeadlinesApi(),
              builder: (BuildContext context, snaphot) {
                if (snaphot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitDualRing(
                    color: Colors.red,
                  ));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snaphot.data!.articles!.length,
                      itemBuilder: (BuildContext context, index) {
                        DateTime dateTime = DateTime.parse(snaphot
                            .data!.articles![index].publishedAt
                            .toString());

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
                                                  sourceName: snaphot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  author: snaphot.data!
                                                      .articles![index].author
                                                      .toString(),
                                                  title: snaphot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  description: snaphot
                                                      .data!
                                                      .articles![index]
                                                      .description
                                                      .toString(),
                                                  urlToImage: snaphot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString(),
                                                  publishedAt: snaphot
                                                      .data!
                                                      .articles![index]
                                                      .publishedAt
                                                      .toString(),
                                                  content: snaphot.data!
                                                      .articles![index].content
                                                      .toString(),
                                                  newsUrl: snaphot.data!
                                                      .articles![index].url
                                                      .toString(),
                                                )));
                                  },
                                  child: Container(
                                    color:
                                        const Color.fromARGB(31, 253, 101, 101),
                                    child: Row(
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
                                            height: height * 0.25,
                                            width: width * 0.62,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snaphot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.aBeeZee(
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style:
                                                            GoogleFonts.adamina(
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Text(
                                                    format.format(dateTime),
                                                    style: GoogleFonts.aBeeZee(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
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
              })
        ],
      ),
    );
  }
}
