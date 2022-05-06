class SearchModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? overViewAR;
  String? overViewEN;
  String? details;
  String? thumbnail;
  double? rate;

  int? categoryID;
  Category? category;

  String? locationLong;
  String? locationLat;
  String? addressAR;
  String? addressEN;
  int? cityID;
  City? city;
  bool? isActive;

  SearchModel(
      {this.id,
      this.nameAR,
      this.nameEN,
      this.overViewAR,
      this.overViewEN,
      this.details,
      this.thumbnail,
      this.rate,
      this.categoryID,
      this.category,
      this.locationLong,
      this.locationLat,
      this.addressAR,
      this.addressEN,
      this.cityID,
      this.city,
      this.isActive});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    overViewAR = json['overViewAR'];
    overViewEN = json['overViewEN'];
    details = json['details'];
    thumbnail = json['thumbnail'];
    rate = json['rate'];
    categoryID = json['categoryID'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    locationLong = json['locationLong'];
    locationLat = json['locationLat'];
    addressAR = json['addressAR'];
    addressEN = json['addressEN'];
    cityID = json['cityID'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    isActive = json['isActive'];
  }
}

class Category {
  int? id;
  String? nameAR;
  String? nameEN;
  String? image;

  Category({this.id, this.nameAR, this.nameEN, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    image = json['image'];
  }
}

class City {
  int? id;
  String? nameAR;
  String? nameEN;
  int? governorateID;

  City({
    this.id,
    this.nameAR,
    this.nameEN,
    this.governorateID,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    governorateID = json['governorateID'];
  }
}
