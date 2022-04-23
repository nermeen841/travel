class CitySearchModel {
  int? id;
  String? nameAR;
  String? nameEN;
  int? governorateID;

  CitySearchModel({
    this.id,
    this.nameAR,
    this.nameEN,
    this.governorateID,
  });

  CitySearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    governorateID = json['governorateID'];
  }
}
