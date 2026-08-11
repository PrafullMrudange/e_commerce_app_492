import 'package:ecommerceapp/data/remote/Models/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState{}
class CategoryLoadingState extends CategoryState{}
class CategoryLoadedState extends CategoryState{
  List<CategoryModel> mCategorys;
  CategoryLoadedState({required this .mCategorys});
}
class CategoryErrorState extends CategoryState{
  String errorMsg;
  CategoryErrorState({required this.errorMsg});
}