import 'package:flutter/material.dart';

enum TabItem { stock, profile }

Map<TabItem, String> tabName = {
  TabItem.stock: "Stock",
  TabItem.profile: "Profil"
};

Map<TabItem, IconData> tabIcon = {
  TabItem.stock: Icons.assignment,
  TabItem.profile: Icons.person
};

Map<TabItem, int> tabIndex = {
  TabItem.stock: 0,
  TabItem.profile: 1
};

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key key, this.currentTab, this.onSelectTab}) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    // Alternative bottom bar
    // return Container(
    //   margin: EdgeInsets.only(left: 8, right: 8),
    //   padding: EdgeInsets.only(top: 8, left: 16, right: 16),
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).scaffoldBackgroundColor,
    //     border: Border.all(color: Theme.of(context).accentColor, width: 1),
    //     // border: Border(
    //     //   left: BorderSide(color: Theme.of(context).accentColor, width: 2),
    //     //   right: BorderSide(color: Theme.of(context).accentColor, width: 2),
    //     //   top: BorderSide(color: Theme.of(context).accentColor, width: 2),
    //     // ),
    //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //   ),
    //   child: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: tabIndex[currentTab],
    //     items: [
    //       _buildItem(context, tabItem: TabItem.dashboard),
    //       _buildItem(context, tabItem: TabItem.plants),
    //       _buildItem(context, tabItem: TabItem.vege_garden),
    //       _buildItem(context, tabItem: TabItem.settings)
    //     ],
    //     onTap: (index) => onSelectTab(
    //       TabItem.values[index],
    //     ),
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     selectedItemColor: Theme.of(context).accentColor,
    //     unselectedItemColor: Theme.of(context).accentColor.withAlpha(150),
    //     iconSize: 24,
    //     elevation: 0,
    //   ),
    // );

    return BottomNavigationBar(
      currentIndex: tabIndex[currentTab],
      items: [
        _buildItem(context, tabItem: TabItem.stock),
        _buildItem(context, tabItem: TabItem.profile),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Colors.black26,
    );
  }

  BottomNavigationBarItem _buildItem(BuildContext context, {TabItem tabItem}) {
    final String text = tabName[tabItem];
    final IconData icon = tabIcon[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        icon
      ),
      title: Text(
        text
      ),
    );
  }
}