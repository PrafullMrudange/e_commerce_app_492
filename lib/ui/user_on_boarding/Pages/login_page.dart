
import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:ecommerceapp/ui/dashboard/dashboard_page.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_bloc.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_event.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_state.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home_page.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isHidden = true;
  bool isLoading = false;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),

                Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.shopping_bag,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Center(
                  child: Text(
                    "Login to continue shopping",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                 SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon:Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: passwordController,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: Icon(
                        isHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                BlocConsumer<UserBloc,UserState>(
                  buildWhen:(ps,cs)=>isLogin,
                  listenWhen: (ps,cs) => isLogin,
                  listener:(context,state) async { if (state is UserLoadingState) {
                    isLoading = true;
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    Navigator.pushReplacementNamed(context,AppRoutes.PAGE_DASHBOARD);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("User Logged In successfully!!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  if (state is UserFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red,));
                  }},
                  builder: (context,state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            isLogin = true;
                           context.read<UserBloc>().add(LoginUserEvent(email: emailController.text, password: passwordController.text));
                          }
                        },
                        child: isLoading ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Please wait...",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ) : Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        isLogin = false;
                        Navigator.pushNamed(
                          context,
                          AppRoutes.PAGE_SIGN_UP
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}