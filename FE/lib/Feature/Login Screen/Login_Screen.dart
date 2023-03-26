import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Core/Colors/Hex_Color.dart';
import '../../Core/background.dart';
import '../Register Screen/Register_Screen.dart';
import '../Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/Animation/Fade_Animation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  signIn(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    final url = "http://10.0.2.2:8080/api/auth/signin";
    final body = {"email": email, "password": password};

    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final jsonResponse = response.body;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', jsonResponse);

      // login success, navigate to home screen
      setState(() {
        isLoading = true;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePg();
      }));
    } else {
      setState(() {
        isLoading = false;
      });

      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4293").withOpacity(0.8),
              HexColor("#4b4293"),
              HexColor("#08418e"),
              HexColor("#08418e")
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(
                  delay: 1,
                  child: Container(
                    child: Text(
                      "Create your account",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                FadeAnimation(
                  delay: 1.2,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeAnimation(
                  delay: 1.3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : FadeAnimation(
                        delay: 1.4,
                        child: Container(
                          width: size.width * 0.75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              signIn(emailController.text,
                                  passwordController.text);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: size.height * 0.02),
                FadeAnimation(
                  delay: 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account? ",
                          style: TextStyle(color: CupertinoColors.white)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
