
import 'package:ecommerceapp/data/remote/Models/view_order_model.dart';

abstract class ViewOrderState {}

class ViewOrderInitialState extends ViewOrderState {}

class ViewOrderLoadingState extends ViewOrderState {}

class ViewOrderSuccessState extends ViewOrderState {
  List<OrderModel> orders;
  String message;
  ViewOrderSuccessState({
    required this.orders,
    required this.message,
  });
}
class ViewOrderErrorState extends ViewOrderState{
  String error;

  ViewOrderErrorState({
    required this.error,
  });
}