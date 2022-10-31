class CreateCategoryResponse {
  String? status;
  String? categoryCode;

  CreateCategoryResponse({this.status, this.categoryCode});

  CreateCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryCode = json['CategoryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['CategoryCode'] = this.categoryCode;
    return data;
  }
}