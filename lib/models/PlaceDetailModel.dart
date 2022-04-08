// ignore_for_file: file_names

class PlaceDetailModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? overViewAR;
  String? overViewEN;
  String? details;
  String? thumbnail;
  double? rate;
  int? subCategoryID;
  SubCategory? subCategory;
  int? advertisorID;
  dynamic advertisor;
  String? locationLong;
  String? locationLat;
  String? addressAR;
  String? addressEN;
  int? cityID;
  City? city;
  bool? isActive;

  PlaceDetailModel(
      {this.id,
      this.nameAR,
      this.nameEN,
      this.overViewAR,
      this.overViewEN,
      this.details,
      this.thumbnail,
      this.rate,
      this.subCategoryID,
      this.subCategory,
      this.advertisorID,
      this.advertisor,
      this.locationLong,
      this.locationLat,
      this.addressAR,
      this.addressEN,
      this.cityID,
      this.city,
      this.isActive});

  PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    overViewAR = json['overViewAR'];
    overViewEN = json['overViewEN'];
    details = json['details'];
    thumbnail = json['thumbnail'];
    rate = json['rate'];
    subCategoryID = json['subCategoryID'];
    subCategory = json['subCategory'] != null
        ? SubCategory.fromJson(json['subCategory'])
        : null;
    advertisorID = json['advertisorID'];
    advertisor = json['advertisor'];
    locationLong = json['locationLong'];
    locationLat = json['locationLat'];
    addressAR = json['addressAR'];
    addressEN = json['addressEN'];
    cityID = json['cityID'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    isActive = json['isActive'];
  }
}

class SubCategory {
  int? id;
  int? categoryID;
  Category? category;
  String? nameAR;
  String? nameEN;
  String? image;

  SubCategory(
      {this.id,
      this.categoryID,
      this.category,
      this.nameAR,
      this.nameEN,
      this.image});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryID = json['categoryID'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    image = json['image'];
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
  Governorate? governorate;
  dynamic thumbnail;

  City(
      {this.id,
      this.nameAR,
      this.nameEN,
      this.governorateID,
      this.governorate,
      this.thumbnail});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    governorateID = json['governorateID'];
    governorate = json['governorate'] != null
        ? Governorate.fromJson(json['governorate'])
        : null;
    thumbnail = json['thumbnail'];
  }
}

class Governorate {
  int? id;
  String? nameAR;
  String? nameEN;
  int? countryID;
  Country? country;

  Governorate(
      {this.id, this.nameAR, this.nameEN, this.countryID, this.country});

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    countryID = json['countryID'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
}

class Country {
  int? id;
  String? nameAR;
  String? nameEN;

  Country({this.id, this.nameAR, this.nameEN});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
  }
}
