import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/screens/islands/island_detail_screen.dart';
import 'package:galapagos_touring/services/auth/auth_interface.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:galapagos_touring/services/database/database_service.dart';
import 'package:galapagos_touring/widgets/common/platform_alert_dialog.dart';
import 'package:galapagos_touring/widgets/island/card_swiper_widget.dart';
import 'package:galapagos_touring/widgets/island/island_card.dart';
import 'package:galapagos_touring/widgets/island/swiper_builder.dart';
import 'package:provider/provider.dart';

class IslandsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Island>>(
      stream: database.islandsStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Island>> snapshot) {
        return SwiperBuilder<Island>(
          snapshot: snapshot,
          itemBuilder: (context, island) => GestureDetector(
            child: Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                _buildBackgroundImage(island),
                _buildNameCard(context, island),
              ],
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
      child: FadeInImage(
        placeholder: AssetImage('assets/images/jar-loading.gif'),
        image: NetworkImage(island.imageUrl),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildNameCard(BuildContext context, Island island) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 160.0,
        width: size.width * 0.9,
        margin: EdgeInsets.only(bottom: 50.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.18),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Isla',
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 25.0,
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        island.name,
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 30.0,
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
