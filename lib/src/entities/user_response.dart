/// accessToken : "string"
/// user : {"firstName":"string","lastName":"string","fullName":"string","email":"string","imgUrl":"string"}

class UserResponse {
  String? accessToken;
  User? user;

  UserResponse({
      this.accessToken, 
      this.user});

  UserResponse.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }


}

/// firstName : "string"
/// lastName : "string"
/// fullName : "string"
/// email : "string"
/// imgUrl : "string"

class User {
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? imgUrl;

  User.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    imgUrl = json['imgUrl'];
  }


}