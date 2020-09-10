import 'package:flutter/material.dart';
import 'package:galapagos_touring/models/island_model.dart';

class IslandCard extends StatelessWidget {
  const IslandCard({Key key, @required this.island}) : super(key: key);
  final Island island;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/jar-loading.gif'),
                    image: NetworkImage(island.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black38,
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: 30.0,
                  child: Text(
                    island.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            // final category = categories[index]['title'].toLowerCase();
            // _interstitialAd?.show();
            // print('interstitial');
            // Navigator.pushNamed(context, 'images', arguments: category.name);
          },
        ),
        SizedBox(height: 20.0)
      ],
    );
  }
}
