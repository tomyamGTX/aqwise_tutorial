class TranslationModel {
  int? id;
  String? text;
  int? languageId;
  int wordId;
  TranslationModel(
      {required this.id,
      required this.languageId,
      required this.text,
      required this.wordId});
}
