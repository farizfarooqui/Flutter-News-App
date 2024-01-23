import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/splash_pic.jpg",
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.50),
              child: Column(
                children: [
                  const Center(
                    child: SpinKitHourGlass(
                      color: Color.fromARGB(255, 134, 134, 12),
                    ),
                  ),
                  const SizedBox(
                    height: 270,
                  ),
                  Center(
                    child: Text('TOP HEADLINES',
                        style: GoogleFonts.anton(
                            letterSpacing: 6,
                            fontSize: 20,
                            color: const Color.fromARGB(255, 134, 134, 12))),
                  ),
                  Center(
                    child: Text('Develop by @farizfarooqui',
                        style: GoogleFonts.asap(
                            letterSpacing: 6,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 134, 12, 12))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
