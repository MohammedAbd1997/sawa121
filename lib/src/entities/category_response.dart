class CategoryResponse {
  int? id;
  String? name;

  CategoryResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

}