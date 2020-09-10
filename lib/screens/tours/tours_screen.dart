import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:provider/provider.dart';

import 'package:galapagos_touring/admob/ad_manager.dart';
import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/models/tour_model.dart';
import 'package:galapagos_touring/screens/tours/tour_detail_screen.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:galapagos_touring/widgets/tour/scroll_list_builder.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({Key key, @required this.island}) : super(key: key);
  final Island island;

  @override
  _ToursScreenState createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  final bool _enableAds = false;

  Tour selectedTour;
  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;

  void _loadIntersitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        print('Interstitial ad loaded');
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        _showTour();
        break;
      default:
      // do nothing
    }
  }

  void _showTour() {
    _interstitialAd?.dispose();
    _interstitialAd = _createIntersitialAd();
    _loadIntersitialAd();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            TourDetailScreen.show(context, tour: selectedTour),
      ),
    );
  }

  InterstitialAd _createIntersitialAd() {
    return InterstitialAd(
        adUnitId: AdManager.interstitialAdUnitId,
        listener: _onInterstitialAdEvent);
  }

  @override
  void initState() {
    super.initState();
    print('Init state');
    _isInterstitialAdReady = false;
    _interstitialAd = _createIntersitialAd();
    _loadIntersitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tours en ${widget.island.name}'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: _buildContents(context, widget.island),
      ),
    );
  }

  Widget _buildContents(BuildContext context, Island island) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Tour>>(
      stream: database.toursStream(island: island),
      builder: (BuildContext context, AsyncSnapshot<List<Tour>> snapshot) {
        return ScrollListBuilder<Tour>(
          snapshot: snapshot,
          itemBuilder: (context, tour) => GestureDetector(
            child: Container(
              width: double.infinity,
              height: 230.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Stack(
                // fit: StackFit.expand,
                children: <Widget>[
                  _buildBackgroundImage(tour),
                  _buildNameCard(context, tour),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                selectedTour = tour;
              });
              if (_enableAds) {
                if (_isInterstitialAdReady) _interstitialAd.show();
              } else {
                _showTour();
              }
            },
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         TourDetailScreen.show(context, tour: tour),
            //   ),
            // ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage(Tour tour) {
    return Positioned.fill(
      child: Hero(
        tag: tour.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.multiply),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/jar-loading.gif'),
              image: NetworkImage(tour.imageUrl),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameCard(BuildContext context, Tour tour) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tour.name,
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 24.0,
              fontFamily: 'Roboto',
              color: Color.fromRGBO(255, 255, 255, 0.90),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.schedule,
                    color: Color.fromRGBO(255, 255, 255, 0.75),
                    size: 17.0,
                  ),
                  Text(
                    ' ${tour.duration} hr  -  ',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 16.0,
                      color: Color.fromRGBO(255, 255, 255, 0.90),
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.star_border,
                    color: Color.fromRGBO(255, 255, 255, 0.75),
                    size: 22.0,
                  ),
                  Text(
                    '  ${tour.rating}',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 16.0,
                      color: Color.fromRGBO(255, 255, 255, 0.90),
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Icon(
              //       Icons.star,
              //       color: Colors.amber[200],
              //       size: 22.0,
              //     ),
              //     Text(
              //       ' ${tour.rating}',
              //       style: TextStyle(
              //         letterSpacing: 1.0,
              //         fontSize: 16.0,
              //         color: Color.fromRGBO(255, 255, 255, 0.90),
              //         fontWeight: FontWeight.w400,
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
