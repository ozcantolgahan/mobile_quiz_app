class CategoryModel {
  int categoryId;
  String categoryName;

  CategoryModel({this.categoryId, this.categoryName});

  CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    this.categoryId = map["categoryId"];
    this.categoryName = map["categoryName"];
  }
}
