import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/data/remote/Models/product_Model.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  ApiHelper apiHelper;
  ProductBloc({required this.apiHelper}) : super(ProductInitialState()){
    on<GetAllProductEvent>((event , emit) async{
      emit(ProductLoadingState());
      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_PRODUCTS,
        );
        if (data["status"]) {

          List<ProductModel> mProducts = [];

          for (Map<String, dynamic> eachMap in data["data"]) {
            mProducts.add(
              ProductModel.fromJson(eachMap),
            );
          }

          emit(
            ProductLoadedState(
              mProducts: mProducts,
            ),
          );
        } else {
          emit(ProductErrorState(error:data["message"]));
        }
      } catch (e) {
        emit(ProductErrorState(error: e.toString()));
      }

    });
  }

}