class CategoryArray {
  CategoryArray({
    this.categoryId,
    this.categoryName,
  });

  CategoryArray.fromJson(dynamic json) {
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
  }

  String? categoryId;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryId'] = categoryId;
    map['CategoryName'] = categoryName;
    return map;
  }
}
