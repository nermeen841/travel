class TopPlacesInCategoryModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? overViewAR;
  String? overViewEN;
  String? details;
  String? thumbnail;
  double? rate;
  // Null? subCategoryID;
  // Null? subCategory;
  int? categoryID;
  // Null? category;
  int? advertisorID;
  // Null? advertisor;
  String? locationLong;
  String? locationLat;
  String? addressAR;
  String? addressEN;
  int? cityID;
  // Null? city;
  // bool? isActive;

  TopPlacesInCategoryModel({
    this.id,
    this.nameAR,
    this.nameEN,
    this.overViewAR,
    this.overViewEN,
    this.details,
    this.thumbnail,
    this.rate,
    // this.subCategoryID,
    // this.subCategory,
    this.categoryID,
    // this.category,
    this.advertisorID,
    // this.advertisor,
    this.locationLong,
    this.locationLat,
    this.addressAR,
    this.addressEN,
    this.cityID,
    // this.city,
    // this.isActive
  });

  TopPlacesInCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    overViewAR = json['overViewAR'];
    overViewEN = json['overViewEN'];
    details = json['details'];
    thumbnail = json['thumbnail'];
    rate = json['rate'];
    // subCategoryID = json['subCategoryID'];
    // subCategory = json['subCategory'];
    categoryID = json['categoryID'];
    // category = json['category'];
    advertisorID = json['advertisorID'];
    // advertisor = json['advertisor'];
    locationLong = json['locationLong'];
    locationLat = json['locationLat'];
    addressAR = json['addressAR'];
    addressEN = json['addressEN'];
    cityID = json['cityID'];
    // city = json['city'];
    // isActive = json['isActive'];
  }
}
