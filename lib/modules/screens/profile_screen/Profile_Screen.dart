import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>LayoutCubit()..getUserData(),
      child: BlocConsumer<LayoutCubit,LayoutState>(
        listener:(context,state){

        } ,
        builder: (context,state){
          final cubit = BlocProvider.of<LayoutCubit>(context);
          return Scaffold(
              backgroundColor: Colors.white,
              body: cubit.userModel != null ?
              Column(
                children:
                [
                  Text(cubit.userModel!.name!),
                  SizedBox(height:10),
                  Text(cubit.userModel!.email!),
                ],
              ) :
              Center(child: CircularProgressIndicator())
          );
    },
      )
    );
  }
}
