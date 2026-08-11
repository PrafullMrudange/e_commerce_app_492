import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/data/remote/Models/user_model.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ApiHelper apiHelper;

  ProfileBloc({required this.apiHelper}) : super(ProfileInitialState()){

    on<GetProfileEvent>((event,emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
       String? token = prefs.getString("token");
      if (token == null || token.isEmpty) {
        emit(ProfileFailureState(errorMsg: "Token not found"));
        return;
      }
      emit(ProfileLoadingState());
      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_PROFILE,
        );
        if (data["status"]) {
          emit(ProfileSuccessState(user:UserModel.fromJson(data["data"])));
        } else {
          emit(ProfileFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(ProfileFailureState(errorMsg: e.toString()));
      }
    });
  }


}