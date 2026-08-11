import 'package:ecommerceapp/data/remote/Models/user_model.dart';
import 'package:ecommerceapp/ui/dashboard/Nav_pages/nav_cart_page.dart';
import 'package:ecommerceapp/ui/dashboard/Nav_pages/nav_fav_page.dart';
import 'package:ecommerceapp/ui/dashboard/Nav_pages/nav_home_page.dart';
import 'package:ecommerceapp/ui/dashboard/Nav_pages/nav_menu_page.dart';
import 'package:ecommerceapp/ui/dashboard/Nav_pages/nav_profile_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> nav_pages = [
    NavMenuPage(),
    NavFavPage(),
    NavHomePage(),
    NavCartPage(),
    NavProfilePage(),
  ];

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(),
      body: nav_pages[selectedIndex],
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            selectedIndex = 2;
            setState(() {});
          },
          backgroundColor:Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(selectedIndex == 2 ? Icons.home : Icons.home_outlined,color: Colors.white,),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin:7,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                selectedIndex = 0;
                setState(() {});
              },
              icon: Icon(
                selectedIndex == 0
                    ? Icons.menu_open_rounded
                    : Icons.menu_open_outlined,
                color: selectedIndex == 0 ? Colors.amber : Colors.black26,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedIndex = 1;
                setState(() {});
              },
              icon: Icon(
                selectedIndex == 1
                    ? Icons.checklist_outlined
                    : Icons.checklist_outlined,
                color: selectedIndex == 1 ? Colors.amber : Colors.black26,
                size: 30,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              onPressed: () {
                selectedIndex = 3;
                setState(() {});
              },
              icon: Icon(
                selectedIndex == 3
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: selectedIndex == 3 ? Colors.amber : Colors.black26,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedIndex = 4;
                setState(() {});
              },
              icon: Icon(
                selectedIndex == 4
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
                color: selectedIndex == 4 ? Colors.amber : Colors.black26,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
