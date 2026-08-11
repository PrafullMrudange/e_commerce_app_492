import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerceapp/data/remote/Models/product_Model.dart';
import 'package:ecommerceapp/domain/constants/app_routes.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_bloc.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_event.dart';
import 'package:ecommerceapp/ui/dashboard/Bloc/Product%20Bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavHomePage extends StatefulWidget {
  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  var currentPage = 0;
  List<String> bannerUrl = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyxa-eLd8zev29fJrS3QzTlELGkqngF4JKEplyHrpWRQ&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsd4kK67BG6vp6UqWDFpKsaJB0YMRgrK_6hRibt3FyLg&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREodNODEQbv_Dz9x3Ai7rubEGfxnfJ7gSon57P6xWZ0Q&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQALWckVvDJ-vIcC-y-wEq7bJrH-aHb-c3ky2BIvwxCZw&s=10",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(GetAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu, size: 30),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none_outlined, size: 30),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, size: 30),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text("search"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.category)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 220,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    itemCount: bannerUrl.length,
                    itemBuilder: (_, index, _) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          image: DecorationImage(
                            image: NetworkImage(bannerUrl[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      onPageChanged: (index, reason) {
                        currentPage = index;
                        setState(() {});
                      },
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 190),
                      DotsIndicator(
                        dotsCount: bannerUrl.length,
                        position: currentPage.toDouble(),
                        decorator: DotsDecorator(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black, width: 1),
                          ),
                          color: Colors.transparent,
                          activeColor: Colors.black,
                          size: Size.square(9.0),
                          activeSize: Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductLoadedState) {
                    List<ProductModel> products = state.mProducts;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        ProductModel product = products[index];

                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.PAGE_PRODUCT_VIEW,
                              arguments: product,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Image.network(
                                    product.image ?? "no image found",
                                  ),
                                ),

                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product.name ?? "",style:TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
                                        Text(" \$${product.price ?? "" }",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is ProductErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
