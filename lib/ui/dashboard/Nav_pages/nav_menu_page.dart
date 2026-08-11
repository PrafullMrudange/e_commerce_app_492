import 'package:ecommerceapp/data/remote/Models/category_model.dart';
import 'package:ecommerceapp/data/remote/Models/product_Model.dart';
import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Category%20Bloc/category_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavMenuPage extends StatefulWidget {

  @override
  State<NavMenuPage> createState() => _NavMenuPageState();
}


class _NavMenuPageState extends State<NavMenuPage> {
  @override

  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductEvent());
    context.read<CategoryBloc>().add(GetAllCategory());
  }

  String? selectedCategory = '0';
  List<DropdownMenuEntry<String>> categoryEntries = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(
            child: Text("Select Category",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width:double.infinity,
              height:100,
              child:BlocBuilder<CategoryBloc,CategoryState>(builder:(context , state){
                if (state is CategoryLoadingState) {
                  return  Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CategoryLoadedState) {
                  List<CategoryModel> categories = state.mCategorys;
                  categoryEntries.clear();
                  for (CategoryModel category in categories) {
                    categoryEntries.add(
                      DropdownMenuEntry<String>(
                        value: category.id.toString(),
                        label: category.name ?? "",
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width:double.infinity,
                      height: 100,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 5),
                        child: DropdownMenu(
                          width: double.infinity,
                          label:Text("Select Category"),
                          dropdownMenuEntries: categoryEntries,
                          onSelected: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }

                if (state is CategoryErrorState) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                }

                return  Text("Category not loaded");
              },
              ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc,ProductState>(
                builder:(context,state) {
                  if (state is ProductLoadingState) {
                    return  Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoadedState) {

                    List<ProductModel> products = state.mProducts;

                    List<ProductModel> filteredProducts =
                    selectedCategory == '0'
                        ? products
                        : products.where((product) {
                      return product.categoryId == selectedCategory;
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (_, index) {

                        ProductModel product = filteredProducts[index];

                        return InkWell(
                          onTap:(){
                            Navigator.pushNamed(context,AppRoutes.PAGE_PRODUCT_VIEW ,arguments: product);
                          },
                          child: Card(
                            margin:EdgeInsets.symmetric(vertical:5,horizontal: 5),
                            child: ListTile(
                              leading: Container(
                                width:100,
                                height: 100,
                                child:Image.network(
                                  product.image ?? "",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              title: Text(product.name ?? "",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                              subtitle: Text("\$${product.price ?? ""}",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                              trailing:Text(product.status == "1" ? "Available" : " Not Available",style: TextStyle(fontSize:14,color:product.status == "1" ? Colors.green : Colors.red),),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is ProductErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return  SizedBox();
                }
            ),
          ),
        ],
      ),
    );
  }
}
