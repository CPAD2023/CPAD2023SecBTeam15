import 'package:cryptoview/pkg/login/signup_page.dart';
import 'package:cryptoview/pkg/main/crypto_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late SharedPreferences _preferences;
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState(){
    _lazyInit();
  }

  void _lazyInit()async{
    _preferences = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade300,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/3.9,
                  top: 70
                ),
                child: const Text(
                  "CRYPTO VIEW",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                    fontFamily: 'Schyler'
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(130,-40),
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 500,
                  ),
                  height: 800,
                  width: 800,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade300,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(-150,80),
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 500,
                  ),
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade300,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                  top: 150,
                  left: 35
                ),
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailIdController,
                        style: const TextStyle(
                          color: Colors.white60
                        ),
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            size: 40,
                            ),
                          iconColor: Colors.deepPurple.shade300,
                          labelText: "Email",
                          hintText: "example@gmail.com",
                          hintStyle: const TextStyle(
                            color: Colors.white54
                          ) 
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle( 
                          color: Colors.white60
                        ),
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            size: 40,
                            ),
                          iconColor: Colors.deepPurple.shade300,
                          labelText: "Password",
                          hintStyle: const TextStyle(
                            color: Colors.white54
                          ) 
                        ),
                      ),
                      const SizedBox(
                        height: 30
                        ),
                      TextButton(
                        onPressed: (){
                          signIn(context);
                        }, 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                          ),
                          ]
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                        TextButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        }, 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                          ),
                          ]
                        )),
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async{

    var email = _emailIdController.text;
    var password = _passwordController.text;
    var localContext = context;

    final uri = Uri(
      scheme: 'https',
      host: 'CPADBackend.cfapps.us10-001.hana.ondemand.com',
      path: '/validateUser',
      queryParameters: {
        'emailId' : email,
        'password' : password
      }
    );

    final response = await http.get(uri);
    if(response.statusCode ==200){
      _preferences.setBool('loggedInBool', true);
      print("logging in....");
      // ignore: use_build_context_synchronously
      Navigator.push(
        localContext,
        MaterialPageRoute(builder: (context) => const CryptoView()),
      );
    }
    else{
    }

    _emailIdController.text = '';
    _passwordController.text = '';
  }
}
