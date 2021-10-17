import 'package:episode_plus/config/screen_routes.dart';
import 'package:episode_plus/config/screen_titles.dart';
import 'package:episode_plus/data/context.dart';
import 'package:episode_plus/data/models/series_model.dart';
import 'package:flutter/material.dart';

class SeriesFormScreen extends StatelessWidget {
  const SeriesFormScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(ScreenTitles.seriesFormScreenTitle),
          automaticallyImplyLeading: false,
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

  bool _isInteger(String s) {
    return int.tryParse(s) != null;
  }

  Widget _currentEpisodeField() => TextFormField(
        validator: (String? inputValue) {
          if (inputValue == null || inputValue.isEmpty) {
            return 'Please enter Current Episode.';
          } else if (inputValue == '0') {
            return 'Please enter a number greater than 0.';
          } else if (_isInteger(inputValue) == false) {
            return 'Please enter an integer value.';
          }
          return null;
        },
        onSaved: (String? inputValue) {
          int _parsedInputValue = int.tryParse(inputValue!)!;
          _currentEpisode = _parsedInputValue;
        },
      );

  Widget _formSubmitButton() => ElevatedButton(
        child: const Text('Submit'),
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          _formKey.currentState!.save();
          await Context.instance.addSeries(
            Series(name: _name, currentEpisode: _currentEpisode),
          );

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$_name Added!')));

          Navigator.pushReplacementNamed(context, ScreenRoutes.homeScreen);
        },
      );

  Widget _formCancelButton() => ElevatedButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, ScreenRoutes.homeScreen);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _nameField(),
          _currentEpisodeField(),
          _formSubmitButton(),
          _formCancelButton(),
        ],
      ),
    );
  }
}
