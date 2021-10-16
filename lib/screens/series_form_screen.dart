import 'package:episode_plus/config/screen_titles.dart';
import 'package:episode_plus/data/repository/series_repository.dart';
import 'package:flutter/material.dart';

class SeriesFormScreen extends StatelessWidget {
  const SeriesFormScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(ScreenTitles.seriesFormScreenTitle),
        ),
        body: SeriesForm(key),
      ),
    );
  }
}

class SeriesForm extends StatefulWidget {
  const SeriesForm(Key? key) : super(key: key);

  @override
  _SeriesFormState createState() => _SeriesFormState();
}

class _SeriesFormState extends State<SeriesForm> {
  late String _name;
  late int _currentEpisode;
  final _formKey = GlobalKey<FormState>();

  Widget _nameField() => TextFormField(
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.isEmpty) {
            return 'Please enter Series Name.';
          }
          return null;
        },
        onSaved: (String? inputValue) {
          _name = inputValue!;
        },
      );

  Widget _currentEpisodeField() => TextFormField(
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.isEmpty) {
            return 'Please enter Series Name.';
          }
          return null;
        },
        onSaved: (String? inputValue) {
          _currentEpisode = int.tryParse(inputValue!)!;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameField(),
          _currentEpisodeField(),
          Center(
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();

                await Series.addSeries(
                  Series(name: _name, currentEpisode: _currentEpisode),
                );

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Series Added Successfully!')));
              },
            ),
          )
        ],
      ),
    );
  }
}
