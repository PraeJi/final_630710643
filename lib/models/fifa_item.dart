class FifaItem{
  final int id;
  final String team;
  final String group;
  final String flagImage;
  final int voteCount;

  FifaItem({
    required this.id,
    required this.team,
    required this.group,
    required this.flagImage,
    required this.voteCount,
  });

  factory FifaItem.fromJson(Map<String, dynamic> json){
    return FifaItem(
        id: json['id'],
        team: json['name'],
        group: json['group'],
        flagImage: json['flagImage'],
        voteCount: json['voteCount'],
    );
  }

  FifaItem.fromJson2(Map<String, dynamic> json)
    : id = json['id'],
      team = json['name'],
      group = json['group'],
      flagImage = json['flagImage'],
      voteCount = json['voteCount'];
}