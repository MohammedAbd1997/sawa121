class CategoryResponse {
  int? id;
  String? name;
  String? nameEn;

  CategoryResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['nameEn'];
  }
}
