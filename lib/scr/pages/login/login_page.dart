import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_bike/scr/pages/home/main_page.dart';

import 'package:http/http.dart' as http;
import 'package:rent_bike/scr/resources/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //For CircularProgressIndicator
  bool visible = false;

  // Getting value from TextField widget
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // SERVER LOGIN API
  Future<void> getRequest() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      String? _email;
      String? _pass;
      _email = emailController.text;
      _pass = passwordController.text;
      var response = await http.get(
        Uri.parse('http://192.168.1.4:3000/api/users/login/' +
            '${_email}' +
            '/' +
            '${_pass}'),
        // body: ({
        //   'email': emailController.text,
        //   'password': passwordController.text,
        // })
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        //print (decodedData);
        if (decodedData.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Email Or Password Is Incorrect"),
              backgroundColor: Colors.deepOrange));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid"), backgroundColor: Colors.deepOrange));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please Enter Your Email Or Password"),
          backgroundColor: Colors.deepOrange));
    }
  }

  // Initially password is obscure
  bool _obscureText = true;

// build UI

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset : false,
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Image(
                image: AssetImage("assets/images/cubesystem_logo.png"),
                height: size.height * 0.35,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Text(
                "Sign to continue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.kFontColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFieldContainer(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail, color: Colors.white70),
                      hintText: "Your Email",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white70),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white70,
                    ),

                    // suffixIcon: Icon(
                    //   Icons.visibility,
                    //   color: Colors.white70,
                    // ),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                alignment: Alignment(0.65, 0.0),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: AppColor.kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        // padding:MaterialStateProperty.all<EdgeInsetsGeometry>(),
                        // EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.kPrimaryColor)),
                    // padding: EdgeInsets.symmetric(vertical:18, horizontal: 40),
                    // color: AppColor.kPrimaryColor,
                    onPressed: () {
                      getRequest();
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have account ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      " create a new account",
                      style: TextStyle(
                        color: AppColor.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: AppColor.kPrimaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}
