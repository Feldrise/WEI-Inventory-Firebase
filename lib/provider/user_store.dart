import 'package:flutter/cupertino.dart';
import 'package:wei_inventory_firebase/models/user.dart';
import 'package:wei_inventory_firebase/services/firebase/firebase_user_service.dart';

class UserStore with ChangeNotifier {
  User _user;

  Future<bool> get isConnected async {
    _user ??= await FirebaseUserService.getUser();

    return _user != null;
  }

  void userLogged(User loggedUser) {
    _user = loggedUser;

    notifyListeners();
  }

  Future userLogOut() async {
    await FirebaseUserService.logOut();
    _user = null;

    notifyListeners();
  }

  String get email => _user.email;
  String get fullName => "${_user.firstName} ${_user.secondName}";
  String get firstName => _user.firstName;
  String get secondName => _user.secondName;
}