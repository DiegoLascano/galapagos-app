import 'package:flutter/material.dart';
import 'package:galapagos_touring/models/tour_model.dart';
import 'package:galapagos_touring/screens/tours/tours_screen.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'package:galapagos_touring/models/island_model.dart';

class IslandDetailScreen extends StatelessWidget {
  const IslandDetailScreen({Key key, @required this.island}) : super(key: key);
  final Island island;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppbar(context, island),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildDescription(context, island),
              _buildFooter(context, island),
              SizedBox(height: 70.0)
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, Island island) {
    return SliverAppBar(
      elevation: 2.0,
      title: Text('Isla ${island.name}'),
      // backgroundColor: Colors.white,
      expandedHeight: 400.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Hero(
          tag: island.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/jar-loading.gif'),
            image: NetworkImage(island.imageUrl),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
        ),
        // centerTitle: true,
        // title: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10.0),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: <Widget>[
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(10.0),
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //           child: Container(
        //             padding:
        //                 EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        //             child: Row(
        //               children: <Widget>[
        //                 Icon(Icons.star, color: Colors.amber, size: 14.0),
        //                 Icon(Icons.star, color: Colors.amber, size: 14.0),
        //                 Icon(Icons.star, color: Colors.amber, size: 14.0),
        //                 Icon(Icons.star, color: Colors.amber, size: 14.0),
        //                 Icon(Icons.star_half, color: Colors.amber, size: 14.0),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Island island) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Isla ${island.name},',
            style: TextStyle(
              fontFamily: 'Roboto',
              letterSpacing: 1,
              color: Color.fromRGBO(0, 0, 0, 0.75),
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Galápagos',
            style: TextStyle(
              fontFamily: 'Roboto',
              letterSpacing: 1,
              color: Color.fromRGBO(0, 0, 0, 0.75),
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.place,
                size: 18.0,
                color: Color.fromRGBO(0, 0, 0, 0.65),
              ),
              Text(
                '  2km del aeropuerto.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(0, 0, 0, 0.65),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Text(
            'DESCRIPCION',
            style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 0.75),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20.0),
          Text(
            island.description,
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(0, 0, 0, 0.65),
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, Island island) {
    return Container(
//      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'EXPLORAR LA ISLA',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 0.75),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 150.0,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black12, BlendMode.multiply),
                                child: Image(
                                  image: AssetImage('assets/images/tours.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'TOURS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ToursScreen(island: island),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 150.0,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black26, BlendMode.multiply),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/hoteles.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'HOTELES',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 150.0,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.black26, BlendMode.multiply),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/galeria.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'GALERIA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
