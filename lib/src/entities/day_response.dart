/// id : 19581
/// time : "09:00"
/// day : "2021-10-28"

class DayResponse {
  int? id;
  String? time;
  String? day;

  DayResponse({
      this.id, 
      this.time, 
      this.day});

  DayResponse.fromJson(dynamic json) {
    id = json['id'];
    time = json['time'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['time'] = time;
    map['day'] = day;
    return map;
  }

}