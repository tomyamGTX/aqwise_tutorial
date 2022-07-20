class ListFavourite {
  List? favouriteList;
  ListFavourite({required this.favouriteList});

  ListFavourite.fromJson(Map<String, dynamic> json) {
    favouriteList = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favourite'] = favouriteList;
    return data;
  }
}

class Favourite {
  String? title;
  String? description;
  Favourite({required this.title, required this.description});

  Favourite.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
