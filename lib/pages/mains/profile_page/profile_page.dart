import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wei_inventory_firebase/pages/mains/profile_page/widgets/user_identity.dart';
import 'package:wei_inventory_firebase/provider/user_store.dart';
import 'package:wei_inventory_firebase/utils/colors_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key, @required this.onPush}) : super(key: key);

  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.portrait,
                size: 96,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: UserIdentity(userStore: userStore,)
              ),
              Expanded(child: Container(),),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () async => _logOut(context, userStore),
                      color: Theme.of(context).accentColor,
                      child: Text("Deconnexion", style: TextStyle(color: contrastColor(Theme.of(context).accentColor)),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _logOut(BuildContext context, UserStore userStore) async {
    await userStore.userLogOut();
  }
}