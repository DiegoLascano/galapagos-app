import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galapagos_touring/models/island_model.dart';

class IslandDetailScreen extends StatelessWidget {
  const IslandDetailScreen({Key key, @required this.island}) : super(key: key);
  final Island island;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(context, island),
          SliverList(
            delegate: SliverChildListDelegate([
              _createDescription(island),
            ]),
          )
        ],
      ),
    );
  }

  Widget _createAppbar(BuildContext context, Island island) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    child: Text('Isla ${island.name}',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.amber, size: 14.0),
                  Icon(Icons.star, color: Colors.amber, size: 14.0),
                  Icon(Icons.star, color: Colors.amber, size: 14.0),
                  Icon(Icons.star, color: Colors.amber, size: 14.0),
                  Icon(Icons.star_half, color: Colors.amber, size: 14.0),
                ],
              )
            ],
          ),
        ),
        background: Hero(
          tag: island.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/jar-loading.gif'),
            image: NetworkImage(island.imageUrl),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _createDescription(Island island) {
    print(island.name);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        island.description,
        style: TextStyle(fontSize: 16.0),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
