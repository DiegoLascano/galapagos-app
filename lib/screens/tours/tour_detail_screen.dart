import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galapagos_touring/blocs/sightseeing_bloc.dart';
import 'package:galapagos_touring/models/sightseeing_model.dart';
import 'package:galapagos_touring/models/tour_model.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:provider/provider.dart';

class TourDetailScreen extends StatelessWidget {
  const TourDetailScreen({
    Key key,
    @required this.tour,
    @required this.bloc,
  }) : super(key: key);
  final Tour tour;
  final SightseeingBloc bloc;

  static Widget show(BuildContext context, {@required Tour tour}) {
    final database = Provider.of<Database>(context, listen: false);
    return Provider<SightseeingBloc>(
      create: (_) => SightseeingBloc(database: database, tour: tour),
      child: Consumer<SightseeingBloc>(
        builder: (context, bloc, _) => TourDetailScreen(
          bloc: bloc,
          tour: tour,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    print(bloc.tourSightseeings(tour));
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppbar(context, tour),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildDetails(context, tour),
              // _buildFooter(context, tour),
              SizedBox(height: 50.0)
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, Tour tour) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, true),
      ),
      elevation: 2.0,
      title: Text('Tour ${tour.name}'),
      // backgroundColor: Colors.white,
      expandedHeight: 400.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Hero(
          tag: tour.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/jar-loading.gif'),
            image: NetworkImage(tour.imageUrl),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, Tour tour) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(tour),
          SizedBox(height: 15.0),
          _buildBadges(context, tour),
          SizedBox(height: 40.0),
          _buildDescription(tour),
          SizedBox(height: 40.0),
          _buildFeatures(context, tour),
          SizedBox(height: 40.0),
          _buildSightseeings(context, tour)
        ],
      ),
    );
  }

  Widget _buildTitle(Tour tour) {
    return Text(
      'Tour ${tour.name}',
      style: TextStyle(
        fontFamily: 'Roboto',
        letterSpacing: 1,
        color: Color.fromRGBO(0, 0, 0, 0.75),
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBadges(BuildContext context, Tour tour) {
    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.schedule,
                size: 15.0,
                color: Colors.white,
              ),
              Text(
                '  ${tour.duration} hr.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 5.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.people_outline,
                size: 16.0,
                color: Colors.white,
              ),
              Text(
                '  ${tour.people}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 5.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star_border,
                size: 16.0,
                color: Colors.white,
              ),
              Text(
                '  ${tour.rating}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(Tour tour) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          tour.description,
          style: TextStyle(
            fontSize: 16.0,
            color: Color.fromRGBO(0, 0, 0, 0.65),
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context, Tour tour) {
    final features = tour.features;
    if (features.length % 3 != 0) {
      do {
        features.add('');
      } while ((features.length % 3 != 0));
    }
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ACTIVIDADES',
            style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 0.75),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 20.0,
            direction: Axis.horizontal,
            children: List.generate(
                features.length, (index) => _buildFeature(features[index])),
          ),
        )
      ],
    );
  }

  Widget _buildFeature(feature) {
    if (feature == '') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: 80.0,
        height: 80.0,
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 40.0,
              child: Icon(Icons.terrain, size: 60.0),
            ),
            SizedBox(height: 10.0),
            Text(feature),
            //          SizedBox(height: 10.0),
          ],
        ),
      );
    }
  }

  Widget _buildSightseeings(BuildContext context, Tour tour) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'AVISTAMIENTOS',
            style: TextStyle(
              letterSpacing: 2.0,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 0.75),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 20.0),
        StreamBuilder<List<Sightseeing>>(
          stream: bloc.tourSightseeing,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Container();
            if (snapshot.hasData) {
              final sightseeings = snapshot.data;
              return SizedBox(
                height: 175.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sightseeings.length,
                  itemBuilder: (context, index) {
                    final sightseeing = sightseeings[index];
                    return Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: SizedBox(
                                height: double.infinity,
                                width: 125.0,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black26, BlendMode.multiply),
                                  child: Image(
                                    image: NetworkImage(sightseeing.imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 125.0,
                              child: Center(
                                child: Text(
                                  sightseeing.name,
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
                            ),
                          ],
                        ),

//                        Column(
//                          children: <Widget>[
//                            Text(sightseeing.name),
//                            SizedBox(
//                              height: 5.0,
//                            ),
//                            Expanded(
//                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(15.0),
//                                child: SizedBox(
//                                  width: 125.0,
//                                  child: ColorFiltered(
//                                    colorFilter: ColorFilter.mode(
//                                        Colors.black12, BlendMode.multiply),
//                                    child: Image(
//                                      image: NetworkImage(sightseeing.imageUrl),
//                                      fit: BoxFit.fill,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
                        if (index + 1 != tour.sightseeing.length)
                          SizedBox(width: 10.0)
                      ],
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
//Column(
//children: <Widget>[
//for (String sightseeing in tour.sightseeing) Text(sightseeing),
//],
//);
