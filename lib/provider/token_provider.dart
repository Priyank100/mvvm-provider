import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {

  // Future<bool> saveUser(UserModel model) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('token', model.token.toString());
  //   notifyListeners();
  //   return true;
  // }
  //
  // Future<UserModel> getUser() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   final String? token = sp.getString('token');
  //   return UserModel(token: token);
  // }

  Future<bool> saveToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', token);
    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token').toString();
    return token;
  }

  Future<bool> removeToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}