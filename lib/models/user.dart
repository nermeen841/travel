class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
}

class User {
  int? iD;
  String? firstName;
  String? lastName;
  String? avatar;
  String? email;
  String? phone;
  bool? isActive;
  bool? isEmailVerified;

  User({
    this.iD,
    this.firstName,
    this.lastName,
    this.avatar,
    this.email,
    this.phone,
    this.isActive,
    this.isEmailVerified,
  });

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    avatar = json['Avatar'];
    email = json['Email'];
    phone = json['Phone'];
    isActive = json['IsActive'];
    isEmailVerified = json['IsEmailVerified'];
  }
}
