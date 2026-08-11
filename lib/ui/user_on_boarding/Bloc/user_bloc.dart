import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_event.dart';
import 'package:ecommerceapp/ui/user_on_boarding/Bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiHelper apiHelper;

  UserBloc({required this.apiHelper}) : super(UserInitialState()) {
    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());
      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_LOGIN,
          mBodyParams: {
            "email": event.email,
            "password": event.password,
          },
          isAuth: true,
        );
        if (data["status"]) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data["tokan"]);
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_SIGN_UP,
          mBodyParams: {
            "name": event.name,
            "mobile_number": event.mobilNo,
            "email": event.email,
            "password": event.password,
          },
          isAuth: true,
        );
        if (data["status"]) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<CheckLogin>((event,emit)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        emit(UserFailureState(errorMsg: "Token not found"));
        return;
      }

      emit(UserLoadingState());
      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_PROFILE,
        );
        if (data["status"]) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }
}
