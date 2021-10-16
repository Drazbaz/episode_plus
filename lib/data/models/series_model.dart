class Series {
  final int? id;
  final String name;
  final int currentEpisode;

  Series({this.id, required this.name, required this.currentEpisode});

  factory Series.fromMap(Map<String, dynamic> json) => Series(
      id: json['id'],
      name: json['name'],
      currentEpisode: json['currentEpisode']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currentEpisode': currentEpisode,
    };
  }
}
