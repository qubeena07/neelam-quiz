class ScoreModel {
  int? id;
  int? score;
  String? timesPlayed;
  int? sender;

  ScoreModel({this.id, this.score, this.timesPlayed, this.sender});

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        id: json['id'] as int?,
        score: json['score'] as int?,
        timesPlayed: json['timesPlayed'] as String?,
        sender: json['sender'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'score': score,
        'timesPlayed': timesPlayed,
        'sender': sender,
      };
}
