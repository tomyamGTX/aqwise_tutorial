class SampleModel {
  String? name;
  SampleModel({required this.name});

  SampleModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
  }
}
