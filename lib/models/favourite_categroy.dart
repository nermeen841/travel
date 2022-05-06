class FavouriteCategroyModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? image;

  FavouriteCategroyModel({this.id, this.nameAR, this.nameEN, this.image});

  FavouriteCategroyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    image = json['image'];
  }
}
