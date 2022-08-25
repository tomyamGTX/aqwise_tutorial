import 'package:aqwise_stripe_payment/edit.module/word.detail.model.dart';
import 'package:flutter/material.dart';

class AyaProvider extends ChangeNotifier {
  AyaProvider() {
    exampleGetDataFromFirebase();
  }
  List<WordDetail> wordDetailList = [];
  exampleGetDataFromFirebase() {
    wordDetailList.addAll([
      WordDetail(
        name: 'Harf',
        id: 3,
        categoryId: 3,
        childType: 'All',
        parent: '1/2',
        isparent: true,
        hasChild: true,
        type: '',
      ),
      WordDetail(
        name: 'Alamat Al Harf',
        id: 4,
        categoryId: 4,
        childType: 'Unique',
        parent: '1/2/3',
        isparent: false,
        hasChild: true,
        type: '',
      ),
      WordDetail(
        name: 'Alamat Al Harf Detail',
        id: 5,
        categoryId: 5,
        childType: 'None',
        parent: '1/2/3/4',
        isparent: false,
        hasChild: false,
        type: '',
      ),
      WordDetail(
        name: 'Harf Multiple Example',
        id: 6,
        categoryId: 6,
        childType: 'Multiple',
        parent: '1/2',
        isparent: true,
        hasChild: true,
        type: '',
      ),
      WordDetail(
        name: 'Harf Multiple child Example 1',
        id: 7,
        categoryId: 7,
        childType: 'None',
        parent: '1/2/6',
        isparent: false,
        hasChild: false,
        type: '',
      ),
      WordDetail(
        name: 'Harf Multiple child Example 2',
        id: 8,
        categoryId: 8,
        childType: 'None',
        parent: '1/2/6',
        isparent: false,
        hasChild: false,
        type: '',
      ),
    ]);
    notifyListeners();
  }

  void removeList(WordDetail data) {
    print('data deleted. Hot Restart to load back data');
    wordDetailList.remove(data);
    notifyListeners();
  }

  void addList(List<WordDetail> newData) {
    wordDetailList.addAll(newData);
    notifyListeners();
  }
}
