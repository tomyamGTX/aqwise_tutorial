class CreateCategoryResponse {
  String? status;
  String? categoryCode;

  CreateCategoryResponse({this.status, this.categoryCode});

  CreateCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryCode = json['CategoryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['CategoryCode'] = categoryCode;
    return data;
  }
}
