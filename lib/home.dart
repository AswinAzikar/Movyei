import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviyee/Screens/tempscreen.dart';
import 'package:moviyee/controllers/Api/remote_data_sorce.dart';
import 'package:moviyee/horizontal_slider_with_title.dart';
import 'package:moviyee/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();
  List<Result> trending = [];

  int offset = 1;
  int toprated_offset = 1;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchForUI(offset);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InfinitePage(),
            ),
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "MOVIEFLIX",
          style: GoogleFonts.anton(color: Colors.red, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.1,
            ),
            trending.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    child: CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: trending.length,
                      options: CarouselOptions(
                        aspectRatio: 1,
                        autoPlay: true,
                        viewportFraction: 0.6,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentPage = index;
                          });
                          if (index == trending.length - 1) {
                            fetchForUI(offset);
                          }
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final imageUrl =
                            'https://image.tmdb.org/t/p/w300${trending[index].posterPath}';
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                trending[index].title!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            SizedBox(height: .05 * screenHeight),
            HorizontalSliderWIthTitle(
              title: "Top Rated Movies",
            ),
            HorizontalSliderWIthTitle(
              title: "Upcoming Movies",
            ),
            SizedBox(height: .05 * screenHeight),
          ],
        ),
      ),
    );
  }

  void fetchForUI(int offset) {
    RemoteDataSorce().fetchTrending(offset).then(
      (value) {
        setState(() {
          trending.addAll(value!.results!);
        });
      },
    ).onError(
      (error, stackTrace) {
        /// set error
      },
    );
  }
}
