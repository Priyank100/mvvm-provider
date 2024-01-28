import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider_example/provider/token_provider.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/utils/utils.dart';

class SplashServices {

  Future<String> getUserToken() => TokenProvider().getToken();

  void checkAuthentication(BuildContext context) async {
    getUserToken().then((token) {
      if(token == 'null' || token == '') {
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(context, error.toString());
    });
  }
}