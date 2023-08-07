// import 'package:aqwise_stripe_payment/edit.module/aya.number.provider.dart';
// import 'package:aqwise_stripe_payment/edit.module/parent.widget.dart';
// import 'package:aqwise_stripe_payment/edit.module/word.detail.model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'child.widget.dart';
//
// class EditModule extends StatefulWidget {
//   const EditModule({Key? key}) : super(key: key);
//
//   @override
//   State<EditModule> createState() => _EditModuleState();
// }
//
// class _EditModuleState extends State<EditModule> {
//   ///example word detail list for word selected
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QuranIrab Edit Module '),
//       ),
//       body: TreeView(
//         startExpanded: true,
//         children: _getChildList(getParentList()),
//       ),
//     );
//   }
//
//   List<Widget> _getChildList(List<WordDetail> childWordDetail) {
//     return childWordDetail.map((word) {
//       if (word.hasChild!) {
//         return Container(
//           margin: const EdgeInsets.only(left: 8),
//           child: TreeViewChild(
//             startExpanded: true,
//             parent: _getWordDetailWidget(word: word),
//             children: _getChildList(getChildList('${word.parent}/${word.id}')),
//           ),
//         );
//       }
//       return Container(
//         margin: const EdgeInsets.only(left: 4.0),
//         child: _getWordDetailWidget(word: word),
//       );
//     }).toList();
//   }
//
//   Widget _getWordDetailWidget({required WordDetail word}) => word.isparent!
//       ? _getParentWidget(wordDetail: word)
//       : _getChildWidget(wordDetail: word);
//
//   ParentWidget _getParentWidget({required WordDetail wordDetail}) =>
//       ParentWidget(data: wordDetail);
//
//   ChildWidget _getChildWidget({required WordDetail wordDetail}) => ChildWidget(
//         data: wordDetail,
//       );
//
//   List<WordDetail> getChildList(String parent) {
//     ///filter list to get child word detail
//     List<WordDetail> child = [];
//     Provider.of<AyaProvider>(context).wordDetailList.forEach((element) {
//       if (element.parent == parent) {
//         child.add(element);
//       }
//     });
//     return child;
//   }
//
//   List<WordDetail> getParentList() {
//     ///filter list to get parent word detail
//     List<WordDetail> parent = [];
//     Provider.of<AyaProvider>(context).wordDetailList.forEach((element) {
//       if (element.isparent!) {
//         parent.add(element);
//       }
//     });
//     return parent;
//   }
// }
