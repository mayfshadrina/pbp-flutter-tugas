import 'package:flutter/material.dart';
import 'package:counter_7/page/drawer.dart';
import 'package:counter_7/model/watchlist.dart';

class WatchlistDetail extends StatelessWidget {
  final WatchList watchList;
  const WatchlistDetail({super.key, required this.watchList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Watchlist'),
        ),
        drawer: makeDrawer(context),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Text(
                  watchList.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Release Date:  ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    watchList.releaseDate,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Rating:  ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    watchList.rating.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Status:  ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    watchList.watched ? "Watched" : "Not Watched Yet",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Flexible(
                    child: const Text(
                      "Review:  ",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      watchList.review,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text(
                  "Kembali",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          // ajhsjkhkjsh
        ));
  }
}
