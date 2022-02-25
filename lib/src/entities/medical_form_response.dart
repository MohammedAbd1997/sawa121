/// id : 16158
/// fullName : "حسن "
/// gender : false
/// telephone : "1234567"
/// yearOfBirth : 0
/// isSmoker : true
/// chronicDisease : ""
/// isPregnant : false
/// address : "test"
/// history : "اعزب"
/// userName : "hosamghrayebb@gmail.com"

class MedicalFormResponse {
  int? id;
  String? fullName;
  bool? gender;
  String? telephone;
  int? yearOfBirth;
  bool? isSmoker;
  String? chronicDisease;
  bool? isPregnant;
  String? address;
  String? history;
  String? userName;


  MedicalFormResponse.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    gender = json['gender'];
    telephone = json['telephone'];
    yearOfBirth = json['yearOfBirth'];
    isSmoker = json['isSmoker'];
    chronicDisease = json['chronicDisease'];
    isPregnant = json['isPregnant'];
    address = json['address'];
    history = json['history'];
    userName = json['userName'];
  }


}