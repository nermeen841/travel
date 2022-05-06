class FavouritePlacesModel {
  int? id;
  String? nameAR;
  String? nameEN;
  String? overViewAR;
  String? overViewEN;
  String? details;
  String? thumbnail;
  double? rate;
  int? categoryID;
  int? advertisorID;
  String? locationLong;
  String? locationLat;
  String? addressAR;
  String? addressEN;

  FavouritePlacesModel({
    this.id,
    this.nameAR,
    this.nameEN,
    this.overViewAR,
    this.overViewEN,
    this.details,
    this.thumbnail,
    this.rate,
    this.categoryID,
    this.advertisorID,
    this.locationLong,
    this.locationLat,
    this.addressAR,
    this.addressEN,
  });

  FavouritePlacesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    overViewAR = json['overViewAR'];
    overViewEN = json['overViewEN'];
    details = json['details'];
    thumbnail = json['thumbnail'];
    rate = json['rate'];
    categoryID = json['categoryID'];
    advertisorID = json['advertisorID'];
    locationLong = json['locationLong'];
    locationLat = json['locationLat'];
    addressAR = json['addressAR'];
    addressEN = json['addressEN'];
  }
}
