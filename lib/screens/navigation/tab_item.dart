import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { islands, search, account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allData = {
    TabItem.islands: TabItemData(title: 'Islands', icon: Icons.work),
    TabItem.search: TabItemData(title: 'Search', icon: Icons.search),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
