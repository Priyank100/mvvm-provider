import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/provider/auth_provider.dart';
import 'package:mvvm_provider_example/resource/components/round_button.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/utils/utils.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  ValueNotifier<bool> _obsecurePass = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _obsecurePass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (value){
                    Utils.fieldFocusChange(context, _emailFocus, _passwordFocus);
                  },
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail_outline)
                )
              ),
              SizedBox(height: 20),
              ValueListenableBuilder(
                  valueListenable: _obsecurePass,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: value,
                      obscuringCharacter: '*',
                      focusNode: _passwordFocus,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_open),
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePass.value = !value;
                            },
                            child: Icon(value ? Icons.visibility : Icons.visibility_off_outlined),
                          )
                      ),
                    );
                  }
              ),
              SizedBox(height: 50),
              RoundButton(
                title: 'Login',
                loading: authProvider.loading,
                onPress: (){
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();
                  if(_emailController.text.trim().isEmpty) {
                    Utils.flushBarErrorMessage(context, 'Please enter email');
                  } else if(_passwordController.text.trim().isEmpty) {
                    Utils.flushBarErrorMessage(context, 'Please enter password');
                  } else if(_passwordController.text.trim().length < 8) {
                    Utils.flushBarErrorMessage(context, 'Please enter 8 digit password');
                  } else {
                    // Map data = {
                    //   "email":_emailController.text.trim(),
                    //   "password":_passwordController.text.trim()
                    // };
                    Map data = {
                      "email":'eve.holt@reqres.in',
                      "password":'qwerty'
                    };
                    authProvider.login(context, data);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
