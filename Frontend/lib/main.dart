import 'package:cryptoview/pkg/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptoview/pkg/main/crypto_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final _preference = snapshot.data!;
            final isLoggedIn = _preference.getBool('loggedInBool') ?? false;
            return isLoggedIn ? const CryptoView() : const LoginPage();
          } else {
            // While waiting for the future to complete, you can show a loading indicator
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
