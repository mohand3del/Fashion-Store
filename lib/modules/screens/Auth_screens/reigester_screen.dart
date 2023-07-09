import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_state.dart';
import 'package:ecommerce_app/modules/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Login_Screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }else if(state is FieldToRegisterState){
              showDialog(context: context, builder: (context)=>AlertDialog(
                content: Text(state.message,style:const TextStyle(color: Colors.white),),
                backgroundColor: Colors.deepOrange,
              ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sing Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(height: 30),
                      _textFieldItem(
                          controller: nameController, hintText: 'User Name'),
                      const SizedBox(height: 20),
                      _textFieldItem(
                          controller: emailController, hintText: 'email'),
                      const SizedBox(height: 20),
                      _textFieldItem(
                          controller: phoneController, hintText: 'Phone'),
                      const SizedBox(height: 20),
                      _textFieldItem(
                          isSecure: true,
                          controller: passwordController,
                          hintText: 'Password'),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          padding: EdgeInsets.symmetric(vertical: 12.5),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            state is RegisterLoadingState
                                ? "Loading...."
                                : 'Register',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text('Already have an account? ',style: TextStyle(color: Colors.black)),
                          SizedBox(width: 4,),
                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: const Text('login in',style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

Widget _textFieldItem(
    {required TextEditingController controller,
    required String hintText,
    bool? isSecure}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "must be input $hintText";
      } else {
        return null;
      }
    },
    obscureText: isSecure ?? false,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      hintText: hintText,
    ),
  );
}
