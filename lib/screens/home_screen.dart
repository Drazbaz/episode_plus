import 'package:episode_plus/config/screen_routes.dart';
import 'package:episode_plus/config/screen_titles.dart';
import 'package:episode_plus/data/repository/series_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(ScreenTitles.homeScreenTitle),
        ),
        body: Center(
          child: FutureBuilder<List<Series>>(
            future: Series.getSeries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Series>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView(
                  children: snapshot.data!.map((series) {
                    return Center(
                      child: ListTile(
                        title: Text(series.name),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        floatingActionButton: ElevatedButton(
          child: const Icon(Icons.add_box_outlined),
          onPressed: () {
            Navigator.pushNamed(context, ScreenRoutes.seriesFormScreen);
          },
        ),
      ),
    );
  }
}
