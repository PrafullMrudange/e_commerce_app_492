
import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_bloc.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => ProfileBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => ProductBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => CategoryBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => ViewCartBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => CartBloc(apiHelper: ApiHelper())),
    BlocProvider(create:(context) => UserBloc(apiHelper: ApiHelper()),),
    BlocProvider(create:(context) => ViewOrderBloc(apiHelper: ApiHelper()),),
    BlocProvider(create:(context) => DecrementCartBloc(apiHelper: ApiHelper()),)
  ], child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:AppRoutes.PAGE_SPLASH,
      routes: AppRoutes.getRoutes(),
    );
  }
}
