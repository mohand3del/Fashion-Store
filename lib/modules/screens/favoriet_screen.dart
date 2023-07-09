import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12.5),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                  ),
                  const SizedBox(height: 12,),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cubit.favorites.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 12.5),
                              color: Colors.grey.withOpacity(0.4),
                              child: Row(
                                children: [
                                  Image.network(
                                    cubit.favorites[index].image!,
                                    height: 100,
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(cubit.favorites[index].name!,maxLines: 1,style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.deepOrange
                                        ),),
                                        Text(cubit.favorites[index].price!
                                            .toString()),
                                        MaterialButton(onPressed:(){
                                          cubit.addOrRemoveFromFavorites(productId: cubit.favorites[index].id.toString());
                                        },
                                        color: Colors.deepOrange,
                                          child: const Text('Remove',style: TextStyle(
                                            color: Colors.white,

                                          ),),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25)
                                          ),

                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
