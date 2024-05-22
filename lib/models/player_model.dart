class PlayerModel {
  String? playerId, fName, lName, email, phoneNum, iso, img;
  int? lives, highestScore;
  DateTime? scoredDate;

  PlayerModel({
    this.email,
    this.fName,
    this.iso,
    this.lName,
    this.phoneNum,
    this.playerId,
    this.img,
    this.lives,
    this.highestScore,
    this.scoredDate,
  });

  PlayerModel.fromMap(Map<String, dynamic> map) {
    email = map.containsKey('email') ? map['email'] ?? '' : '';
    fName = map.containsKey('fName') ? map['fName'] ?? '' : '';
    lName = map.containsKey('lName') ? map['lName'] ?? '' : '';
    iso = map.containsKey('iso') ? map['iso'] ?? '' : '';
    img = map.containsKey('img') ? map['img'] ?? '' : '';
    lives = map.containsKey('lives') ? map['lives'] ?? 0 : 0;
    phoneNum = map.containsKey('phoneNum') ? map['phoneNum'] ?? '' : '';
    playerId = map.containsKey('playerId') ? map['playerId'] ?? '' : '';
    highestScore =
        map.containsKey('highestScore') ? map['highestScore'] ?? 0 : 0;
    scoredDate = map.containsKey('scoredDate')
        ? map['scoredDate'].toDate()
        : DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      if (playerId != null) 'playerId': playerId,
      if (email != null) 'email': email,
      if (fName != null) 'fName': fName,
      if (lName != null) 'lName': lName,
      if (phoneNum != null) 'phoneNum': phoneNum,
      if (iso != null) 'iso': iso,
      if (img != null) 'img': img,
      if (lives != null) 'lives': lives,
      if (highestScore != null) 'highestScore': highestScore,
      if (scoredDate != null) 'scoredDate': scoredDate,
    };
  }
}
