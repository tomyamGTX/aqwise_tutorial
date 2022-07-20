import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'favourite.model.dart';

class FavouriteProvider extends ChangeNotifier {
  FavouriteProvider() {
    getList();
  }

  List<Favourite> favouriteList = <Favourite>[];

  Future<void> getList() async {
    // GetStorage().remove('favList');
    // var jsonData = [
    //   {"title": "Hei", "description": "Bye"}
    // ];

    var localData = GetStorage().read('favList');

    if (localData != null) {
      var data = ListFavourite.fromJson(localData).favouriteList;
      favouriteList = data!.map((e) => Favourite.fromJson(e)).toList();
    }
  }

  Future<void> addToFavourite(
      BuildContext context, String title, String description) async {
    var newData = Favourite(title: title, description: description);
    if (favouriteList.isEmpty) {
      favouriteList.add(newData);
    } else {
      bool duplicate = favouriteList.any((element) => element.title == title);
      if (!duplicate) {
        favouriteList.add(newData);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data added')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data already exist')));
      }
    }
    notifyListeners();
    saveToLocal();
  }

  void saveToLocal() {
    var jsonData = ListFavourite(favouriteList: favouriteList).toJson();
    GetStorage().write('favList', jsonData);
    notifyListeners();
  }

  void deleteFav(BuildContext context, Favourite item) {
    favouriteList.remove(item);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data deleted')));
    saveToLocal();
    notifyListeners();
  }
}
