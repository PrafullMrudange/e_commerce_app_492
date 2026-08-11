import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';

class DecrementCartBloc
    extends Bloc<DecrementCartEvent, DecrementCartState> {

  ApiHelper apiHelper;

  DecrementCartBloc({
    required this.apiHelper,
  }) : super(DecrementCartInitialState()) {

    on<DecrementCartProductEvent>(
          (event, emit) async {

        emit(DecrementCartLoadingState());

        try {

          var data = await apiHelper.postAPI(
            url: AppUrls.URL_DECREMENT_CART_ITEM,

            mBodyParams: {
              "user_id": event.userId,
              "product_id": event.productId,
              "quantity": event.quantity,
            },
          );

          if (data["status"] == true) {

            emit(
              DecrementCartSuccessState(
                message: data["message"] ??
                    "Quantity decreased",
              ),
            );

          } else {

            emit(
              DecrementCartErrorState(
                error: data["message"] ??
                    "Unable to decrease quantity",
              ),
            );
          }

        } catch (e) {

          emit(
            DecrementCartErrorState(
              error: e.toString(),
            ),
          );
        }
      },
    );
  }
}