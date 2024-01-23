import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String sourceName,
      author,
      title,
      description,
      urlToImage,
      publishedAt,
      content,
      newsUrl;
  const DetailScreen(
      {super.key,
      required this.sourceName,
      required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.newsUrl});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final widht = MediaQuery.of(context).size.width * 1;
    final format = DateFormat('MMMM dd, yyyy');
    DateTime dateTime = DateTime.parse(widget.publishedAt);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: widht,
        child: Stack(
          children: [
            SizedBox(
              height: height * 0.40,
              width: widht,
              child: CachedNetworkImage(
                  fit: BoxFit.cover, imageUrl: widget.urlToImage),
            ),
            Positioned(
              top: height * 0.37,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: widht,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.title,
                            style: GoogleFonts.aclonica(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.sourceName,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.blue, fontSize: 16),
                              ),
                              Text(
                                format.format(dateTime),
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description :',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Text(
                            widget.description,
                            style: GoogleFonts.aBeeZee(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Center(
            child: Text(
              'URL',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () async {
            // ignore: unnecessary_null_comparison
            if (widget.newsUrl != null &&
                await canLaunchUrl(Uri.parse(widget.newsUrl))) {
              await launchUrl(Uri.parse(widget.newsUrl));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('URL is not available or null')));
            }
          }),
    );
  }
}
