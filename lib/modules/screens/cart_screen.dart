import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                      child: cubit.carts.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: cubit.carts.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cubit.carts[index].image!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            cubit.carts[index].name!,
                                            style: const TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${cubit.carts[index].price!} \$"),
                                              if (cubit.carts[index].price !=
                                                  cubit.carts[index].oldPrice)
                                                Text(
                                                  "${cubit.carts[index].oldPrice!} \$",
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                            ],
                                          ),
                                        const  SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveFromFavorites(productId: cubit.carts[index].id.toString());
                                                },
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: cubit.favoritesId
                                                          .contains(cubit
                                                              .carts[index].id
                                                              .toString())
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                child:  const  Icon(Icons.delete,color: Colors.red,),
                                                onTap: (){
                                                   cubit.addOrRemoveFromCarts(id: cubit.carts[index].id.toString());
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                );
                              })
                          : const Center(
                              child: Text("Loading..."),
                            )),
                  Container(
                    child: Text('Total Price : ${cubit.totalPrice}'),
                  )
                ],
              ),
            );
          },
        ));
  }
}
