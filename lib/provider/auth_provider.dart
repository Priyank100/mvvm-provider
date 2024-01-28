import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider_example/provider/token_provider.dart';
import 'package:mvvm_provider_example/repository/auth_repo.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {

  final _authRepo = AuthRepo();

  bool _loading = false;
  bool get loading => _loading;

  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, var data) async {
    setLoading(true);
    _authRepo.loginApi(data).then((response) {
      setLoading(false);
      final tokenProvider = Provider.of<TokenProvider>(context , listen: false);
      tokenProvider.saveToken(response['token'].toString());
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(context, error.toString());
    });
  }

  Future<void> register(BuildContext context, var data) async {
    setRegisterLoading(true);
    _authRepo.registerApi(data).then((response) {
      setRegisterLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setRegisterLoading(false);
      Utils.flushBarErrorMessage(context, error.toString());
    });
  }

}