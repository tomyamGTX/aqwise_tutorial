import 'package:aqwise_stripe_payment/favourite_list/favourite.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteProvider>(builder: (context, fav, _) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Favourite List'),
            actions: [
              IconButton(
                  onPressed: () {
                    fav.addToFavourite(
                        context,
                        'Favourite no ${fav.favouriteList.length + 1}',
                        'Favourite description');
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: ListView.builder(
            itemCount: fav.favouriteList.length,
            itemBuilder: (BuildContext context, int index) {
              var data = fav.favouriteList[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.image),
                ),
                title: Text(data.title!),
                subtitle: Text(data.description!),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    fav.deleteFav(context, data);
                  },
                ),
              );
            },
          ));
    });
  }
}
