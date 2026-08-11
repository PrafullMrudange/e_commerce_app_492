import 'dart:async';

import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(  Duration(seconds: 3), () async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  token = prefs.getString("token") ?? "";

      String nextPage = AppRoutes.PAGE_LOGIN;

      if(token.isNotEmpty){
       nextPage = AppRoutes.PAGE_DASHBOARD;
      }

      Navigator.pushReplacementNamed(
        context,
        nextPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            Icon(
              Icons.shopping_bag,
              size: 90,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "ShopEasy",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your Shopping Partner",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}