class SuraRelationshipModel {
  String? id;
  String? createdAt;
  String? medinaMushafPageId;
  String? suraId;
  String? updateAt;
  SuraRelationshipModel(
      {required this.createdAt,
      required this.id,
      required this.medinaMushafPageId,
      required this.suraId,
      required this.updateAt});

  SuraRelationshipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    medinaMushafPageId = json['medina_mushaf_page_id'];
    suraId = json['sura_id'];
    updateAt = json['updated_at'];
  }
}
