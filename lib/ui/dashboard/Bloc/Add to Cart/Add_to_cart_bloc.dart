import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ApiHelper apiHelper;

  CartBloc({required this.apiHelper}) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrls.URL_ADD_TO_CART,
          mBodyParams: {
            "product_id": event.productId,
            "quantity": event.quantity,
          },
        );

        if (data["status"] == true) {
          emit(CartSuccessState());
        } else {
          emit(CartErrorState(error: data["message"]));
        }
      } catch (e) {
        emit(CartErrorState(error: e.toString()));
      }
    });
  }
}
