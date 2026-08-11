import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/data/remote/Models/cart_model.dart';
import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCartBloc extends Bloc<ViewCartEvent, ViewCartState> {

  ApiHelper apiHelper;

  ViewCartBloc({
    required this.apiHelper,
  }) : super(ViewCartInitialState()) {

    on<GetCartEvent>((event, emit) async {

      emit(ViewCartLoadingState());

      try {

        dynamic data = await apiHelper.getAPI(
          url: AppUrls.URL_VIEW_CART,
        );

        if (data["status"] == true) {

          List<CartModel> cartItems = [];

          for (Map<String, dynamic> eachMap in data["data"]) {
            cartItems.add(
              CartModel.fromJson(eachMap),
            );
          }

          emit(
            ViewCartLoadedState(
              cartItems: cartItems,
            ),
          );

        } else {

          emit(
            ViewCartErrorState(
              error: data["message"],
            ),
          );
        }

      } catch (e) {

        emit(
          ViewCartErrorState(
            error: e.toString(),
          ),
        );
      }
    });
  }
}