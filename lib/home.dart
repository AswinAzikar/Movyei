import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width < 200
        ? MediaQuery.of(context).size.width
        : 200;
    double containerHeight = MediaQuery.of(context).size.height < 300
        ? MediaQuery.of(context).size.height
        : 300;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "FLUTFLIX",
          style: GoogleFonts.anton(color: Colors.red, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Trending movies",
                style:
                    GoogleFonts.abel(textStyle: const TextStyle(fontSize: 24)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: containerHeight,
                    autoPlay: true,
                    viewportFraction: 0.55,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return ClipRect(
                    
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        color: Colors.yellow,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
