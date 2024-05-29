class GameModel {
  int? prize;
  String? gameId, lastWonBy;
  DateTime? canReplayAfter;

  GameModel({
    this.prize,
    this.canReplayAfter,
    this.gameId,
    this.lastWonBy,
  });

  GameModel.fromMap(Map<String, dynamic> map) {
    gameId = map.containsKey('gameId') ? gameId = map['gameId'] : '';
    lastWonBy =
        map.containsKey('lastWonBy') ? lastWonBy = map['lastWonBy'] : '';
    prize = map.containsKey('prize') ? prize = map['prize'] : '';
    canReplayAfter = map.containsKey('canReplayAfter')
        ? canReplayAfter = map['canReplayAfter'].toDate()
        : DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      if (gameId != null) 'gameId': gameId,
      if (lastWonBy != null) 'lastWonBy': lastWonBy,
      if (prize != null) 'prize': prize,
      if (canReplayAfter != null) 'canReplayAfter': canReplayAfter,
    };
  }
}
