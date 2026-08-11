import 'package:ecommerceapp/data/remote/Models/view_order_model.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view-order_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Get_order_bloc/view_order_state.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Profile_Bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
   OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(
      GetProfileEvent(),
    );
  }

  void getOrders() {

    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileSuccessState) {

      final int userId = int.parse(profileState.user.id);

      context.read<ViewOrderBloc>().add(
        GetOrdersEvent(
          userId: userId,
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF5F6FA),

      appBar: AppBar(
        title:  Text(
          "My Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, profileState) {

          if (profileState is ProfileSuccessState) {

            final int userId =
            int.parse(profileState.user.id);

            context.read<ViewOrderBloc>().add(
              GetOrdersEvent(
                userId: userId,
              ),
            );
          }

          if (profileState is ProfileFailureState) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(profileState.errorMsg),
              ),
            );
          }
        },

        child: BlocBuilder<ViewOrderBloc, ViewOrderState>(
          builder: (context, state) {
            
            if (state is ViewOrderLoadingState) {
              return  Center(
                child: CircularProgressIndicator(
                  color: Color(0xff4F46E5),
                ),
              );
            }



            if (state is ViewOrderErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                     Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                     SizedBox(height: 15),

                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 16,
                      ),
                    ),

                     SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {
                        getOrders();
                      },
                      child:  Text("Retry"),
                    ),
                  ],
                ),
              );
            }


            if (state is ViewOrderSuccessState) {

              if (state.orders.isEmpty) {
                return  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.receipt_long_outlined,
                        size: 80,
                        color: Color(0xff4F46E5),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "No Orders Yet",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Your orders will appear here",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                color:  Color(0xff4F46E5),

                onRefresh: () async {
                  getOrders();
                },

                child: ListView.builder(
                  padding:  EdgeInsets.all(14),
                  itemCount: state.orders.length,

                  itemBuilder: (context, index) {

                    OrderModel order =
                    state.orders[index];

                    return Container(
                      margin:  EdgeInsets.only(
                        bottom: 16,
                      ),

                      padding:  EdgeInsets.all(16),

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

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                            children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                   Text(
                                    "Order Number",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),

                                   SizedBox(height: 4),

                                  Text(
                                    "#${order.orderNumber}",
                                    style:  TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                padding:
                                 EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.green,

                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),

                                child: Text(
                                  getOrderStatus(
                                    order.status,
                                  ),

                                  style:  TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),

                           SizedBox(height: 15),

                           Divider(),

                           SizedBox(height: 10),
                          

                          ...order.products.map(
                                (product) {

                              return Container(
                                margin:
                                 EdgeInsets.only(
                                  bottom: 12,
                                ),

                                child: Row(
                                  children: [
                                    
                                    Container(
                                      width: 75,
                                      height: 75,

                                      padding:
                                       EdgeInsets.all(7),

                                      decoration: BoxDecoration(
                                        color:
                                         Color(
                                          0xffF5F6FA,
                                        ),

                                        borderRadius:
                                        BorderRadius.circular(
                                          12,
                                        ),
                                      ),

                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,

                                        errorBuilder:
                                            (
                                            context,
                                            error,
                                            stackTrace,
                                            ) {
                                          return  Icon(
                                            Icons
                                                .image_not_supported_outlined,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                                    ),

                                     SizedBox(width: 12),
                                    
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                        children: [

                                          Text(
                                            product.name,

                                            maxLines: 2,

                                            overflow:
                                            TextOverflow.ellipsis,

                                            style:
                                             TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),

                                           SizedBox(height: 6),

                                          Text(
                                            "Qty: ${product.quantity}",
                                            style:
                                             TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),

                                           SizedBox(height: 5),

                                          Text(
                                            "₹${product.price}",
                                            style:
                                             TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold,
                                              color:
                                              Color(
                                                0xff4F46E5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                           Divider(),

                           SizedBox(height: 8),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                            children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                   Text(
                                    "Order Date",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),

                                   SizedBox(height: 4),

                                  Text(
                                    order.createdAt,
                                    style:  TextStyle(
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,

                                children: [

                                   Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),

                                   SizedBox(height: 4),

                                  Text(
                                    "₹${order.totalAmount}",
                                    style:  TextStyle(
                                      fontSize: 19,
                                      fontWeight:
                                      FontWeight.bold,
                                      color:
                                      Color(0xff4F46E5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            return  Center(
              child: Text(
                "Orders not loaded",
              ),
            );
          },
        ),
      ),
    );
  }

  String getOrderStatus(String status) {

    switch (status) {

      case "1":
        return "Confirmed";

      case "2":
        return "Processing";

      case "3":
        return "Shipped";

      case "4":
        return "Delivered";

      case "5":
        return "Cancelled";

      default:
        return "Unknown";
    }
  }
}