import 'package:flutter/material.dart';
import 'package:galapagos_touring/text_styles.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/screens/islands/island_detail_screen.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:galapagos_touring/widgets/island/swiper_builder.dart';

class IslandsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _buildHeader(),
            Expanded(
              child: _buildContents(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Text(
          'Descubre las islas encantadas',
          style:
              CustomTextStyles.titleStyle(color: Colors.grey[900], size: 30.0),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Island>>(
      stream: database.islandsStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Island>> snapshot) {
        return SwiperBuilder<Island>(
          snapshot: snapshot,
          pageController: PageController(initialPage: 0, viewportFraction: 0.8),
          pageSnapping: true,
          itemBuilder: (context, island) => GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 50.0),
              child: Stack(
                // fit: StackFit.expand,
                children: <Widget>[
                  _buildBackgroundImage(island),
                  _buildNameCard(context, island),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => IslandDetailScreen(island: island),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage(Island island) {
    return Positioned.fill(
      child: Hero(
        tag: island.id,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey[400].withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(5, 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/jar-loading.gif'),
              image: NetworkImage(island.imageUrl),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameCard(BuildContext context, Island island) {
    // final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100.0,
        // width: size.width * 0.6,
        margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
        decoration: BoxDecoration(
          // color: Color.fromRGBO(0, 0, 0, 0.18),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Isla ${island.name}',
                style: TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 28.0,
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Galápagos',
                style: TextStyle(
                  fontSize: 23.0,
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Icon(Icons.star, color: Colors.amber, size: 18.0),
              //     Icon(Icons.star, color: Colors.amber, size: 18.0),
              //     Icon(Icons.star, color: Colors.amber, size: 18.0),
              //     Icon(Icons.star, color: Colors.amber, size: 18.0),
              //     Icon(Icons.star_half, color: Colors.amber, size: 18.0),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
