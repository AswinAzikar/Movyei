import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:moviyee/Screens/DetailScreen.dart';
import 'package:moviyee/Screens/DetailScreen_carousel.dart';

import '../controllers/Api/remote_data_sorce.dart';
import '../models/movie_model.dart';

class HorizontalSliderWIthTitle extends StatefulWidget {
  const HorizontalSliderWIthTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HorizontalSliderWIthTitle> createState() =>
      _HorizontalSliderWIthTitleState();
}

class _HorizontalSliderWIthTitleState extends State<HorizontalSliderWIthTitle> {
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      fetchpage(pageKey);
    });
  }

  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> fetchpage(int pageKey) async {
    final String sectionName;
    if (widget.title == 'Upcoming Movies') {
      sectionName = "upcoming";
    } else if (widget.title == "Top Rated") {
      sectionName = "top_rated";
    } else {
      sectionName = "now_playing";
    }
    final items = await RemoteDataSorce.fetchMovies(pageKey, sectionName);
    if (items.length < 20) {
      _pagingController.appendLastPage(items);
    } else {
      _pagingController.appendPage(items, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget.title,
            style: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily, fontSize: 22),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: PagedListView<int, Result>(
            scrollDirection: Axis.horizontal,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Result>(
              itemBuilder: (context, item, index) {
                final imageUrl =
                    'https://image.tmdb.org/t/p/w500${item.posterPath}';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(result: item)));
                  },
                  child: AspectRatio(
                    aspectRatio: .7,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Text(item.title ?? "")
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
