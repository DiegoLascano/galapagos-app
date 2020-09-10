import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:galapagos_touring/admob/ad_manager.dart';
import 'package:galapagos_touring/widgets/island/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ScrollListBuilder<T> extends StatefulWidget {
  const ScrollListBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  _ScrollListBuilderState<T> createState() => _ScrollListBuilderState<T>();
}

class _ScrollListBuilderState<T> extends State<ScrollListBuilder<T>> {
  final _nativeAdController = NativeAdmobController();
  double _nativeAdHeight = 0.0;

  StreamSubscription _subscription;

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _nativeAdHeight = 0.0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _nativeAdHeight = 200.0;
        });
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final items = widget.snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (widget.snapshot.hasError) {
      print(widget.snapshot.error);
      return EmptyContent(
        title: 'Something were wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (index == 1) {
          return Column(
            children: <Widget>[
              _buildNativeAd(),
              widget.itemBuilder(context, items[index])
            ],
          );
        } else {
          return widget.itemBuilder(context, items[index]);
        }
      },
    );
  }

  Widget _buildNativeAd() {
    return Container(
      height: _nativeAdHeight,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: (_nativeAdHeight / 13)),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: NativeAdmob(
//          error: Text('Error al cargar el anuncio'),
          adUnitID: AdManager.nativeAdUnitId,
          controller: _nativeAdController,
          options: NativeAdmobOptions(
            showMediaContent: true,
            ratingColor: Theme.of(context).accentColor,
            bodyTextStyle: NativeTextStyle(
              color: Colors.black87,
            ),
            adLabelTextStyle: NativeTextStyle(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            headlineTextStyle: NativeTextStyle(
              color: Colors.grey[900],
            ),
            callToActionStyle: NativeTextStyle(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
