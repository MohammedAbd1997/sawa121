/// longitude : 35.187335
/// latitude : 31.794574

class MapPointModel {
  double? longitude;
  double? latitude;

  MapPointModel({
      this.longitude, 
      this.latitude});

  MapPointModel.fromJson(dynamic json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }

}