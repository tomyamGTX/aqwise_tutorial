// To parse this JSON data, do
//
//     final sliceData = sliceDataFromJson(jsonString);

class SlicingData {
  SlicingData({
    required this.start,
    required this.end,
    required this.wordId,
  });

  int start;
  int end;
  int? wordId;

  factory SlicingData.fromJson(Map<String, dynamic> json) => SlicingData(
        start: json["start"],
        end: json["end"],
        wordId: json["word_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "word_id": wordId,
      };
}
