import 'package:flutter/material.dart';
import '../../Core/Colors/Hex_Color.dart';
import '../../Core/background.dart';
import 'package:http/http.dart' as http;
import '../Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/Animation/Fade_Animation.dart';
import '../Login Screen/Login_Screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback? press;

  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account? " : "Already have an Account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  register(String email, String username, String password) async {
    setState(() {
      isLoading = true;
    });

    final url = "http://10.0.2.2:8080/api/auth/signup";
    final body = {"username": username, "email": email, "password": password};

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final jsonResponse = response.body;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', jsonResponse);

      // registration success, navigate to home screen

      setState(() {
        isLoading = true;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePg();
      }));
    } else {
      setState(() {
        isLoading = false;
      });

      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed. Please try again later."),
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
                  delay: 0.8,
                  child: FadeInImage(
                    height: 100,
                    width: 100,
                    placeholder: AssetImage('assets/avatar.gif'),
                    image: NetworkImage('https://e7.pngegg.com/pngimages/20/1014/png-clipart-computer-icons-user-icon-design-graphics-friend-icons-blue-computer.png'),
                  ),
                ),
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
                const SizedBox(
                  height: 10,
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
                    width: 300,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    width: 300,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                // Phone number field
                FadeAnimation(
                  delay: 1.6,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                        icon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                // Password field
                FadeAnimation(
                  delay: 1.9,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                // Confirm Password field
                FadeAnimation(
                  delay: 1.4,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                FadeAnimation(
                  delay: 1.5,
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : TextButton(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF2697FF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14.0, horizontal: 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                          onPressed: () {
                            if(passwordController.text.isEmpty || emailController.text.isEmpty || nameController.text.isEmpty || phoneController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "All the fields are required"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                            else if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Passwords do not match. Please try again."),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else {
                              register(emailController.text, nameController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                ),
                SizedBox(height: size.height * 0.03),
                FadeAnimation(
                  delay: 1.6,
                  child: AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
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
