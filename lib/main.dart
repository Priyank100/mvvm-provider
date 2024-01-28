import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/provider/auth_provider.dart';
import 'package:mvvm_provider_example/provider/home_provider.dart';
import 'package:mvvm_provider_example/provider/token_provider.dart';
import 'package:mvvm_provider_example/utils/routes/routes.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/view/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => TokenProvider())
        ],
      child: MaterialApp(
        title: 'MVVM Provider Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      )
    );
  }
}
