import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesData = BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        child:GridView.builder(
          itemCount:categoriesData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing:15,

            ),
            itemBuilder: (context,index) {
            return Container(
              child:Column(
                children: [
                  Expanded(child: Image.network(categoriesData[index].url!),),
                 const SizedBox(height: 10,),
                  Text(categoriesData[index].title!),
                ],
              ),
            );
            }
        ),
      ),

    );
  }
}
