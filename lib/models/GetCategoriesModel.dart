// ignore_for_file: file_names

class CategoryModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? image;

  CategoryModel({this.id, this.nameAR, this.nameEN, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    image = json['image'];
  }
}
