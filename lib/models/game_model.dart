class GameModel {
  String? prize;
  String? gameId, lastWonBy;
  DateTime? canReplayAfter;
  int? playCount;

  GameModel({
    this.prize,
    this.canReplayAfter,
    this.gameId,
    this.lastWonBy,
    this.playCount,
  });

  GameModel.fromMap(Map<String, dynamic> map) {
    gameId = map.containsKey('gameId') ? gameId = map['gameId'] : '';
    lastWonBy =
        map.containsKey('lastWonBy') ? lastWonBy = map['lastWonBy'] : '';
    prize = map.containsKey('prize') ? prize = map['prize'] : '0';
    playCount = map.containsKey('playCount') ? map['playCount'] : 0;
    canReplayAfter = map.containsKey('canReplayAfter')
        ? canReplayAfter = map['canReplayAfter'].toDate()
        : DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      if (gameId != null) 'gameId': gameId,
      if (lastWonBy != null) 'lastWonBy': lastWonBy,
      if (prize != null) 'prize': prize,
      if (playCount != null) 'playCount': playCount,
      if (canReplayAfter != null) 'canReplayAfter': canReplayAfter,
    };
  }
}
