import 'package:aqwise_stripe_payment/edit.module/aya.number.provider.dart';
import 'package:aqwise_stripe_payment/edit.module/word.detail.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentWidget extends StatefulWidget {
  final WordDetail data;

  const ParentWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  List<bool> _value = [false, false, false];
  List<WordDetail> newData = [];
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorDark,
      child: ListTile(
        title: Text(
          '(${widget.data.parent}) ${widget.data.name} ',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.data.childType!,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          onPressed: () async {
            if (widget.data.hasChild!) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  var type = widget.data.childType;
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: Text(
                          'Example checkbox for ${widget.data.childType!}'),
                      content: SizedBox(
                          height: 200,
                          width: 100,
                          child: uiBasedOnChildType(type!)),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _value = [false, false, false];
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Changes?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              _value = [false, false, false];
                                            });
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Provider.of<AyaProvider>(context,
                                                    listen: false)
                                                .addList(newData);
                                          },
                                          child: const Text('Yes'))
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Save'))
                      ],
                    );
                  });
                },
              );
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            Provider.of<AyaProvider>(context, listen: false)
                                .removeList(widget.data);
                          },
                          child: const Text('Yes'))
                    ],
                  );
                },
              );
            }
          },
          icon: Icon(
            widget.data.hasChild! ? Icons.edit : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  uiBasedOnChildType(String type) {
    if (type == 'All') {
      return StatefulBuilder(builder: (context, setState) {
        return Column(
          children: const [
            Text('DropDown'),
          ],
        );
      });
    } else if (type == 'Multiple') {
      return StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            ///retrieve and display all child from parent
            for (int i = 0; i < _value.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ), //SizedBox

                  Flexible(
                    child: Text(
                      Provider.of<AyaProvider>(context).wordDetailList[i].name!,
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ), //Text
                  const SizedBox(width: 10), //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: _value[i],
                    onChanged: (bool? value) {
                      setState(() {
                        ///add selected child
                        newData.add(WordDetail(
                            name:
                                Provider.of<AyaProvider>(context, listen: false)
                                    .wordDetailList[i]
                                    .name!,
                            type: '',
                            childType: 'None',

                            ///based on id in wordCategory
                            categoryId: 10,

                            ///based on id in wordRelationShip
                            id: 10,

                            ///if childType equals to None return false
                            hasChild: false,

                            ///if ancestry has more than 2 (/) return false EG:1/2/3/4 will return false
                            isparent: false,

                            ///for new child, parent value get from combining wordDetail.parent and wordDetail.id from the parent
                            parent:
                                '${widget.data.parent!}/${widget.data.id}'));
                        _value[i] = value!;
                      });
                    },
                  ), //Checkbox
                ], //<Widget>[]
              ),
          ],
        );
      });
    } else if (type == 'Unique') {
      return StatefulBuilder(builder: (context, setState) {
        return Column(
          children: const [Text('RadioButton')],
        );
      });
    } else {
      return Container();
    }
  }
}
