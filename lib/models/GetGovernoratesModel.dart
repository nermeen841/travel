// ignore_for_file: file_names

class GetGovernoratesModel {
  int? id;
  String? nameAR;
  String? nameEN;
  // int? countryID;
  // Null? country;

  GetGovernoratesModel({
    this.id,
    this.nameAR,
    this.nameEN,
  });

  GetGovernoratesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAR = json['nameAR'];
    nameEN = json['nameEN'];
    // countryID = json['countryID'];
    // country = json['country'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['nameAR'] = this.nameAR;
  //   data['nameEN'] = this.nameEN;
  //   // data['countryID'] = this.countryID;
  //   // data['country'] = this.country;
  //   return data;
  // }
}
