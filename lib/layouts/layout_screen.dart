import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>(
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor:  Colors.white,
              elevation: 0,
              title: const Text(
                'Fashion Store',
                style: TextStyle(
                  fontSize:25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: cubit.bottomNavIndex,
              selectedItemColor:Colors.deepOrange,
              unselectedItemColor:Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
              cubit.changeNavIndex(index: index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Categorise'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),


              ],

            ),
            body: cubit.layoutScreens[cubit.bottomNavIndex],
            backgroundColor:  Color(0xfffdfbda),
          );
        },
        listener:(context,state){

        } );
  }
}
