import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/pages/mains/home_page/home_page.dart';
import 'package:wei_inventory_firebase/pages/mains/profile_page/profile_page.dart';
import 'package:wei_inventory_firebase/pages/mains/widgets/bottom_navigation.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key key, this.navigatorKey, this.tabItem}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {String destinationPage}) {
    final routeBuilders = _routeBuilders(context);

    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders['/$destinationPage'](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    // return {
    //   TabNavigatorRoutes.root: (context) => MorningPage(),
    //   TabNavigatorRoutes.morning: (context) => MorningPage(),
    //   TabNavigatorRoutes.reminders: (context) => RemindersPage(),
    //   TabNavigatorRoutes.tenWordsPage: (context) => TenWordsPage(),
    // };

    if (tabItem == TabItem.profile) {
      return {
        TabNavigatorRoutes.root: (context) => ProfilePage(
          onPush: (destinationPage) => _push(context, destinationPage: destinationPage),
        )
      };
    }

    return {
      TabNavigatorRoutes.root: (context) => HomePage(
        onPush: (destinationPage) => _push(context, destinationPage: destinationPage),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<Map<String, Widget Function(BuildContext)>>(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
