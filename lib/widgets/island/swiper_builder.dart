import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:galapagos_touring/widgets/island/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class SwiperBuilder<T> extends StatelessWidget {
  const SwiperBuilder(
      {Key key,
      @required this.snapshot,
      @required this.itemBuilder,
      @required this.pageController})
      : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(size, items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something were wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(Size size, List<T> items) {
    return PageView.builder(
      pageSnapping: true,
      controller: pageController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
    // return Swiper(
    //   layout: SwiperLayout.STACK,
    //   itemHeight: double.infinity,
    //   itemWidth: double.infinity,
    //   itemCount: items.length,
    //   itemBuilder: (context, index) {
    //     return itemBuilder(context, items[index]);
    //   },
    // );
    // return ListView.separated(
    //   itemCount: items.length + 2,
    //   separatorBuilder: (_, __) => Divider(height: 1.5),
    //   itemBuilder: (context, index) {
    //     if (index == 0 || index == items.length + 1) return Container();
    //     return itemBuilder(context, items[index - 1]);
    //   },
    // );
  }
}
