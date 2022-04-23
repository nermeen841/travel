class HomeCategoryModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? image;

  HomeCategoryModel({this.id, this.nameAR, this.nameEN, this.image});

  HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    image = json['image'];
  }
}
