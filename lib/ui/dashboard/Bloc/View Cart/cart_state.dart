import 'package:ecommerceapp/data/remote/Models/cart_model.dart';

abstract class ViewCartState {}

class ViewCartInitialState extends ViewCartState {}

class ViewCartLoadingState extends ViewCartState {}

class ViewCartLoadedState extends ViewCartState {
  List<CartModel> cartItems;

  ViewCartLoadedState({
    required this.cartItems,
  });
}

class ViewCartErrorState extends ViewCartState {
  String error;

  ViewCartErrorState({
    required this.error,
  });
}