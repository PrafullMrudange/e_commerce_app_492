import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/data/remote/Models/category_model.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  ApiHelper apiHelper;
  CategoryBloc({required this.apiHelper}) : super(CategoryInitialState()){

    on<GetAllCategory>((event,emit) async {
      emit(CategoryLoadingState());
      try {
        dynamic data = await apiHelper.getAPI(
          url: AppUrls.URL_CATEGORIES,
        );
        if (data["status"]) {

          List<CategoryModel> mCategory = [];

          for (Map<String, dynamic> eachMap in data["data"]) {
            mCategory.add(
              CategoryModel.fromJson(eachMap),
            );
          }
          emit(
            CategoryLoadedState(
              mCategorys: mCategory,
            ),
          );
        } else {
          emit(CategoryErrorState(errorMsg:data["message"]));
        }
      } catch (e) {
        emit(CategoryErrorState(errorMsg: e.toString()));
      }

    });
  }
}