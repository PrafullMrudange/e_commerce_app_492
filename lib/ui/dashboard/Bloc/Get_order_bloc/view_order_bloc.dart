import 'package:ecommerceapp/data/remote/ApiHelper/api_helper.dart';
import 'package:ecommerceapp/data/remote/Models/view_order_model.dart';

import 'package:ecommerceapp/domain/constants/app_urls.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view-order_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewOrderBloc extends Bloc<ViewOrderEvent,ViewOrderState> {

  ApiHelper apiHelper;

  ViewOrderBloc({
    required this.apiHelper,
  }) : super(ViewOrderInitialState()) {

    on<GetOrdersEvent>((event, emit) async {

      emit(ViewOrderLoadingState());

      try {

        var data = await apiHelper.postAPI(
          url: AppUrls.URL_VIEW_ORDER,

          mBodyParams: {
            "user_id": event.userId,
          },
        );

        if (data["status"] == true) {

          List<OrderModel> orders = [];

          for (var order in data["orders"]) {
            orders.add(
              OrderModel.fromJson(order),
            );
          }

          emit(
            ViewOrderSuccessState(
              orders: orders,
              message: data["message"] ?? "Order data found",
            ),
          );

        } else {

          emit(
            ViewOrderErrorState(
              error: data["message"] ??
                  "Unable to get orders",
            ),
          );
        }

      } catch (e) {

        emit(
          ViewOrderErrorState(
            error: e.toString(),
          ),
        );
      }
    });
  }
}