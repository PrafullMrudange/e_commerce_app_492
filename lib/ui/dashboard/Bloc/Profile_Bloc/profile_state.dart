import 'package:ecommerceapp/data/remote/Models/user_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileSuccessState extends ProfileState{
  UserModel user;
  ProfileSuccessState({required this.user});
}
class ProfileFailureState extends ProfileState{
  String errorMsg;
  ProfileFailureState({required this.errorMsg});
}