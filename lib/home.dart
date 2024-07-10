import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviyee/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isloading = true;
  ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();
    List<Result> result = [];
  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handlenext();
    _fetchdata(offset);
  }

  void handlenext() {
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          _fetchdata(offset);
        }
      },
    );
  }

  Future<void> _fetchdata(paraOffset) async {
    final dio = Dio();
    print(offset);
    try {
      var response = await dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=b426ac0d6d34af117beb43c263b8d2ed');
      if (response.statusCode == 200) {
        print(response.data);
        print("success");

        ModelClass modelClass = ModelClass.fromJson(response.data);
        result += modelClass.results;
        int localOffset = offset + 15;

        setState(() {
          _isloading = false;
          offset = localOffset;
        });
      }
    } catch (e) {
      print("Error   $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.width;

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
          "MOVIEFLIX",
          style: GoogleFonts.anton(color: Colors.red, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Trending movies",
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                   carouselController:carouselController,
                    itemCount: result.length,
                    options: CarouselOptions(
                      height: containerHeight,
                      autoPlay: true,
                      viewportFraction: 0.55,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          height: containerHeight,
                          width: containerWidth,
                          color: Colors.yellow,
                     //     child: 
                      ));
                    }),
              ),
              SizedBox(height: .1 * screenheight),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Top rated movies",
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: .02 * screenheight),
              SizedBox(
                height: containerHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        color: Colors.amber,
                        height: containerHeight,
                        width: containerWidth,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: .1 * screenheight),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Upcomming movies",
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: .02 * screenheight),
              SizedBox(
                height: containerHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        color: Colors.amber,
                        height: containerHeight,
                        width: containerWidth,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
