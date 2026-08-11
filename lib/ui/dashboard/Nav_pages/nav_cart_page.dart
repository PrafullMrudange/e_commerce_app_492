import 'package:ecommerceapp/data/remote/Models/cart_model.dart';

import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Decrement%20bloc/decrement_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view-order_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_state.dart';

import 'package:ecommerceapp/ui/dashboard/Bloc/Oder%20Bloc/oder_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Oder%20Bloc/oder_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Oder%20Bloc/order_bloc.dart';

import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/View%20Cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavCartPage extends StatefulWidget {
   NavCartPage({super.key});

  @override
  State<NavCartPage> createState() => _NavCartPageState();
}

class _NavCartPageState extends State<NavCartPage> {

  @override
  void initState() {
    super.initState();

    context.read<ViewCartBloc>().add(
      GetCartEvent(),
    );

    context.read<ProfileBloc>().add(
      GetProfileEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF5F6FA),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        title:  Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      // =====================================================
      // ORDER LISTENER
      // =====================================================

      body: BlocListener<ViewOrderBloc, ViewOrderState>(
        listener: (context, orderState) {

          // ORDER SUCCESS
          if (orderState is ViewOrderSuccessState) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  orderState.message,
                ),
              ),
            );

            // You can navigate to Orders page here
            // Navigator.push(...);
          }

          // ORDER ERROR
          if (orderState is ViewOrderErrorState) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  orderState.error,
                ),
              ),
            );
          }
        },

        // =====================================================
        // DECREMENT LISTENER
        // =====================================================

        child: BlocListener<DecrementCartBloc, DecrementCartState>(
          listener: (context, decrementState) {

            // DECREMENT SUCCESS
            if (decrementState is DecrementCartSuccessState) {

              // Refresh cart
              context.read<ViewCartBloc>().add(
                GetCartEvent(),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    decrementState.message,
                  ),
                ),
              );
            }

            // DECREMENT ERROR
            if (decrementState is DecrementCartErrorState) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    decrementState.error,
                  ),
                ),
              );
            }
          },

          // =====================================================
          // VIEW CART BUILDER
          // =====================================================

          child: BlocBuilder<ViewCartBloc, ViewCartState>(
            builder: (context, state) {

              // =================================================
              // CART LOADING
              // =================================================

              if (state is ViewCartLoadingState) {
                return  Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff4F46E5),
                  ),
                );
              }

              // =================================================
              // CART ERROR
              // =================================================

              if (state is ViewCartErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                       Icon(
                        Icons.shopping_cart_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),

                       SizedBox(height: 15),

                       Text(
                        "Add Product to Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                       SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {
                          context.read<ViewCartBloc>().add(
                            GetCartEvent(),
                          );
                        },
                        child:  Text(
                          "Retry",
                        ),
                      ),
                    ],
                  ),
                );
              }

              // =================================================
              // CART LOADED
              // =================================================

              if (state is ViewCartLoadedState) {

                List<CartModel> cartItems = state.cartItems;

                // ===============================================
                // EMPTY CART
                // ===============================================

                if (cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          padding:  EdgeInsets.all(25),
                          decoration:  BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child:  Icon(
                            Icons.shopping_cart_outlined,
                            size: 70,
                            color: Color(0xff4F46E5),
                          ),
                        ),

                         SizedBox(height: 20),

                         Text(
                          "Your Cart is Empty",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                         SizedBox(height: 8),

                         Text(
                          "Add some products to your cart",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ===============================================
                // CALCULATE TOTAL
                // ===============================================

                double total = 0;

                for (CartModel cart in cartItems) {
                  total +=
                      double.parse(cart.price) * cart.quantity;
                }

                // ===============================================
                // CART UI
                // ===============================================

                return Column(
                  children: [

                    // ===========================================
                    // TOTAL + ORDER BUTTON
                    // ===========================================

                    Container(
                      width: double.infinity,

                      padding:  EdgeInsets.all(18),

                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(22),
                        ),
                      ),

                      child: Column(
                        children: [

                          // CART TOTAL
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                               Text(
                                "Cart Total",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff344054),
                                ),
                              ),

                              Text(
                                "₹${total.toStringAsFixed(2)}",
                                style:  TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4F46E5),
                                ),
                              ),
                            ],
                          ),

                           SizedBox(height: 14),

                          // =====================================
                          // ORDER BUTTON
                          // =====================================

                          SizedBox(
                            width: double.infinity,
                            height: 52,

                            child: ElevatedButton(
                              onPressed: () {

                                final profileState =
                                    context
                                        .read<ProfileBloc>()
                                        .state;

                                // PROFILE AVAILABLE
                                if (profileState
                                is ProfileSuccessState) {

                                  final int userId =
                                  int.parse(
                                    profileState.user.id,
                                  );

                                  // CREATE ORDER
                                  context
                                      .read<ViewOrderBloc>()
                                      .add(
                                    GetOrdersEvent(
                                      userId: userId,
                                    ),
                                  );

                                } else {

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                     SnackBar(
                                      content: Text(
                                        "User information not available",
                                      ),
                                    ),
                                  );
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                 Color(0xff4F46E5),
                                foregroundColor: Colors.white,
                                elevation: 2,

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(14),
                                ),
                              ),

                              child:  Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [

                                  Icon(
                                    Icons.shopping_bag_outlined,
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    "Proceed to Checkout",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===========================================
                    // CART ITEMS
                    // ===========================================

                    Expanded(
                      child: ListView.builder(
                        padding:  EdgeInsets.all(14),

                        itemCount: cartItems.length,

                        itemBuilder: (context, index) {

                          CartModel cart =
                          cartItems[index];

                          return Container(
                            margin:  EdgeInsets.only(
                              bottom: 12,
                            ),

                            padding:  EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                              BorderRadius.circular(18),

                              boxShadow:  [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),

                            child: Row(
                              children: [

                                // =================================
                                // PRODUCT IMAGE
                                // =================================

                                Container(
                                  width: 85,
                                  height: 85,

                                  padding:
                                   EdgeInsets.all(8),

                                  decoration: BoxDecoration(
                                    color:
                                     Color(0xffF5F6FA),

                                    borderRadius:
                                    BorderRadius.circular(14),
                                  ),

                                  child: Image.network(
                                    cart.image,

                                    fit: BoxFit.contain,

                                    errorBuilder:
                                        (context, error, stackTrace) {

                                      return  Icon(
                                        Icons
                                            .image_not_supported_outlined,
                                        color: Colors.grey,
                                        size: 35,
                                      );
                                    },
                                  ),
                                ),

                                 SizedBox(width: 14),

                                // =================================
                                // PRODUCT DETAILS
                                // =================================

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      // PRODUCT NAME
                                      Text(
                                        cart.name,

                                        maxLines: 1,

                                        overflow:
                                        TextOverflow.ellipsis,

                                        style:  TextStyle(
                                          fontSize: 17,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                       SizedBox(height: 8),

                                      // PRODUCT PRICE
                                      Text(
                                        "₹${cart.price}",

                                        style:  TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Color(0xff4F46E5),
                                        ),
                                      ),

                                       SizedBox(height: 8),

                                      // =================================
                                      // QUANTITY + DECREMENT
                                      // =================================

                                      Row(
                                        children: [

                                          Container(
                                            padding:
                                             EdgeInsets
                                                .symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),

                                            decoration:
                                            BoxDecoration(
                                              color:
                                               Color(
                                                  0xffF5F6FA),

                                              borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                            ),

                                            child: Text(
                                              "Qty: ${cart.quantity}",

                                              style:
                                               TextStyle(
                                                fontWeight:
                                                FontWeight.w600,
                                                color:
                                                Colors.grey,
                                              ),
                                            ),
                                          ),

                                           Spacer(),

                                          // =================================
                                          // DECREMENT BUTTON
                                          // =================================

                                          IconButton(
                                            onPressed: () {

                                              final profileState =
                                                  context
                                                      .read<
                                                      ProfileBloc>()
                                                      .state;

                                              if (profileState
                                              is ProfileSuccessState) {

                                                final int userId =
                                                int.parse(
                                                  profileState
                                                      .user.id,
                                                );

                                                context
                                                    .read<
                                                    DecrementCartBloc>()
                                                    .add(
                                                  DecrementCartProductEvent(
                                                    userId: userId,

                                                    productId:
                                                    cart.productId,

                                                    quantity: 1,
                                                  ),
                                                );

                                              } else {

                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                   SnackBar(
                                                    content: Text(
                                                      "User information not available",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },

                                            icon:  Icon(
                                              Icons
                                                  .remove_circle_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              // =================================================
              // DEFAULT
              // =================================================

              return  Center(
                child: Text(
                  "Cart not loaded",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}