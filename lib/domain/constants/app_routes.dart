import 'package:ecommerceapp/ui/dashboard/Nav_pages/product_view_page.dart';
import 'package:ecommerceapp/ui/dashboard/dashboard_page.dart';
import 'package:ecommerceapp/ui/splash/Splash_screen.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Pages/login_page.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Pages/sign_up_page.dart';

import 'package:flutter/cupertino.dart';

class AppRoutes {

  static const String PAGE_SPLASH = "/";
  static const String PAGE_LOGIN = "login";
  static const String PAGE_SIGN_UP = "sign_up";
  static const String PAGE_DASHBOARD = "dashboard";
  static const String PAGE_PRODUCT_VIEW = "product_view";

  static Map<String , WidgetBuilder> getRoutes() => {
    PAGE_SPLASH: (context) => SplashPage(),
    PAGE_LOGIN: (context) => LoginPage(),
    PAGE_SIGN_UP: (context) => SignUpPage(),
    PAGE_DASHBOARD: (context) => DashboardPage(),
    PAGE_PRODUCT_VIEW: (context) => ProductViewPage(),
  };
}