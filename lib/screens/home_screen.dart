import 'package:episode_plus/config/screen_routes.dart';
import 'package:episode_plus/config/screen_titles.dart';
import 'package:episode_plus/data/context.dart';
import 'package:episode_plus/data/models/series_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(ScreenTitles.homeScreenTitle),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: HomeScreenList(
            key: key,
          ),
        ),
        floatingActionButton: ElevatedButton(
          child: const Icon(Icons.add_box_outlined),
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, ScreenRoutes.seriesFormScreen);
          },
        ),
      ),
    );
  }
}

class HomeScreenList extends StatefulWidget {
  const HomeScreenList({Key? key}) : super(key: key);

  @override
  _HomeScreenListState createState() => _HomeScreenListState();
}

class _HomeScreenListState extends State<HomeScreenList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Series>>(
      future: Context.instance.getSeries(),
      builder: (BuildContext context, AsyncSnapshot<List<Series>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Loading...'),
          );
        } else {
          return ListView(
            children: snapshot.data!.map((series) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  Context.instance.deleteSeries(series.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${series.name} deleted.')));
                },
                child: ListTile(
                  title: Text(series.name),
                  subtitle: Text('Current Episode: ${series.currentEpisode}'),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
