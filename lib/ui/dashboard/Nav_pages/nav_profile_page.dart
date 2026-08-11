import 'package:ecommerceapp/data/remote/Models/user_model.dart';
import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavProfilePage extends StatefulWidget {
  @override
  State<NavProfilePage> createState() => _NavProfilePageState();
}

class _NavProfilePageState extends State<NavProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile & Personal Info",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [IconButton(onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.pushReplacementNamed(context, AppRoutes.PAGE_LOGIN);
        }, icon: Icon(Icons.logout))],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileSuccessState) {
            UserModel user = state.user;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 10,
                    surfaceTintColor: Colors.cyan,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blueAccent,
                            ),
                            child: Center(
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            user.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20,),
                Text("Personal Details",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color:Colors.black54),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:Container(
                    width:double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" ID :- ${user.id}",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                          Text(" Name :- ${user.name}",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                          Text(" Email :- ${user.email}",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                          Text(" Mobile Number :- ${user.mobile}",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is ProfileFailureState) {
            return Center(child: Text(state.errorMsg));
          }
          return SizedBox();
        },
      ),
    );
  }
}
