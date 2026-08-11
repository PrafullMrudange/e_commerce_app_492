import 'package:ecommerceapp/data/remote/Models/product_Model.dart';
import 'package:ecommerceapp/data/remote/Models/user_model.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Add%20to%20Cart/Add_to_cart_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductModel product =
    ModalRoute
        .of(context)!
        .settings
        .arguments as ProductModel;

    return Scaffold(
      backgroundColor: Color(0xffF5F6FA),

      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [


            Container(
              margin: EdgeInsets.all(16),
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Image.network(
                  product.image ?? "",
                  fit: BoxFit.contain,
                ),
              ),
            ),


            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffEEF2FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Category ${product.categoryId ?? ""}",
                      style: TextStyle(
                        color: Color(0xff4F46E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),


                  Text(
                    product.name ?? "",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff172033),
                    ),
                  ),

                  SizedBox(height: 12),


                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfffff4d6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "4.5",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),

                      Text(
                        "120 Reviews",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),


                  Text(
                    "₹${product.price ?? ""}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F46E5),
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Inclusive of all taxes",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(height: 25),

                  Divider(),

                  SizedBox(height: 20),


                  Text(
                    "Product Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),


                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF8F9FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.green,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Availability",
                          style: TextStyle(
                            color: Color(0xff667085),
                          ),
                        ),

                        Spacer(),

                        Text(
                          "In Stock",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),


                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF8F9FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Delivery",
                          style: TextStyle(
                            color: Color(0xff667085),
                          ),
                        ),

                        Spacer(),

                        Text(
                          "Free Delivery",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),


                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF8F9FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          color: Colors.deepPurple,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Status",
                          style: TextStyle(
                            color: Color(0xff667085),
                          ),
                        ),

                        Spacer(),

                        Text(
                          product.status == "1" ? "Available" : "Not Available",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  BlocListener<CartBloc ,CartState>(
                    listener:(_,state) {

                      if (state is CartSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Product Added to cart"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }

                      if (state is CartErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.read<CartBloc>().add(AddToCartEvent(
                                    productId: int.parse(product.id ?? "0"),
                                    quantity: 1,
                                ));
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                              ),
                              label: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                Color(0xff4F46E5),
                                side: BorderSide(
                                  color: Color(0xff4F46E5),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton.icon(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.shopping_bag_outlined,
                              ),
                              label: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Color(0xff4F46E5),
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}