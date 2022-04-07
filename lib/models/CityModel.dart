class CityModel {
  int? id;
  String? nameAR;
  String? nameEN;
  int? governorateID;
  // /Null? thumbnail;

  CityModel(
      {this.id,
        this.nameAR,
        this.nameEN,
        this.governorateID,
        // this.governorate,
        // this.thumbnail
      });

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    governorateID = json['governorateID'];
    // governorate = json['governorate'];
    // thumbnail = json['thumbnail'];
  }


}