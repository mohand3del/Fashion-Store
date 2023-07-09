import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/models/producr_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(shrinkWrap: true, children: [
                TextFormField(
                  onChanged: (input) {
                    cubit.filterProducts(input: input);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      suffixIcon: const Icon(Icons.clear),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                cubit.banners.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: PageView.builder(
                            controller: pageController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: Image.network(
                                  cubit.banners[index].url!,
                                  fit: BoxFit.fill,
                                ),
                              );
                            })),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const SlideEffect(
                          spacing: 8.0,
                          radius: 25,
                          dotWidth: 16,
                          dotHeight: 16.0,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1.5,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.deepOrange)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                cubit.categories.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  cubit.categories[index].url!,
                                ),
                              );
                            })),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                cubit.products.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : GridView.builder(
                        itemCount: cubit.filteredProducts.isEmpty
                            ? cubit.products.length
                            : cubit.filteredProducts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.7),
                        itemBuilder: (context, index) {
                          return _productItem(
                              model: cubit.filteredProducts.isEmpty
                                  ? cubit.products[index]
                                  : cubit.filteredProducts[index], cubit: cubit);
                              
                          
                        })
              ]),
            ),
            backgroundColor: Colors.white,
          );
        },
        listener: (context, state) {});
  }
}

Widget _productItem({required ProductModel model,required LayoutCubit cubit}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 38),
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          children: [
            Expanded(
                child: Image.network(
                  model.image!,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          "${model.price!} \$",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "${model.oldPrice!} \$",
                          style: const TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )),
                GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color:cubit.favoritesId.contains(model.id.toString()) ?Colors.red : Colors.grey,
                  ),
                  onTap: () {
                    cubit.addOrRemoveFromFavorites(productId: model.id.toString());
                  },
                ),
              ],
            )
          ],
        ),
      ),
      CircleAvatar(
        backgroundColor: Colors.black,
        child: GestureDetector(
          onTap: (){
           cubit.addOrRemoveFromCarts(id: model.id.toString());
          },
          child: Icon(Icons.add_shopping_cart,color: cubit.cartsId.contains(model.id.toString())? Colors.deepOrange : Colors.white),
        ),
      )
    ],
  );
}
