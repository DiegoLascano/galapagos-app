import 'package:flutter/material.dart';
import 'package:galapagos_touring/screens/account/account_screen.dart';
import 'package:galapagos_touring/screens/islands/islands_screen.dart';
import 'package:galapagos_touring/screens/navigation/cupertino_home_scaffold.dart';
import 'package:galapagos_touring/screens/navigation/tab_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabItem _currentTab = TabItem.islands;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.islands: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.islands: (_) => IslandsScreen(),
      TabItem.search: (context) => Container(),
      TabItem.account: (_) => AccountScreen(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectedTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
