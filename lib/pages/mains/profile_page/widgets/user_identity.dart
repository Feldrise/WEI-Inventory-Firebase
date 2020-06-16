import 'package:flutter/material.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/shared/widgets/bordered_card.dart';

class UserIdentity extends StatelessWidget {
  const UserIdentity({Key key, @required this.userStore}) : super(key: key);

  final UserStore userStore;

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      child: ListView(
        primary: false,
        shrinkWrap: true,
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: const Icon(Icons.mail),
              title: Text(userStore.email, style: Theme.of(context).textTheme.bodyText1,),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(userStore.fullName, style: Theme.of(context).textTheme.bodyText1),
            )
          ],
        ).toList()
      ),
    );
  }

}