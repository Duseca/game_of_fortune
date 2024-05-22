class ChoicesModel {
  bool? left, right;

  ChoicesModel({this.left, this.right});

  ChoicesModel.fromMap(Map<String, dynamic> map) {
    left = map.containsKey('left') ? map['left'] ?? false : false;
    right = map.containsKey('right') ? map['right'] ?? true : true;
  }

  Map<String, dynamic> toMap() {
    return {
      if (left != null) 'left': left,
      if (right != null) 'right': right,
    };
  }
}
