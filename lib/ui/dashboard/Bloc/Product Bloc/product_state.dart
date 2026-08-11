import 'package:ecommerceapp/data/remote/Models/product_Model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState{}
class ProductLoadingState extends ProductState{}
class ProductLoadedState extends ProductState{
  List<ProductModel> mProducts;
  ProductLoadedState({required this.mProducts});
}
class ProductErrorState extends ProductState{
  String error;
  ProductErrorState({required this.error});
}