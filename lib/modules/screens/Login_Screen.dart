import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_state.dart';
import 'package:ecommerce_app/modules/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Auth_screens/reigester_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/auth_background.png'),
                  fit: BoxFit.fill)),
          child: BlocConsumer<AuthCubit,AuthStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              if (state is FieldToLoginState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Container(
                  height:50,
                  alignment: Alignment.center,
                  child: Text(state.message),
                )));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          'Login To Continue Process',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                ),
                                validator: (input) {
                                  if (emailController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'must be input email';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                ),
                                validator: (input) {
                                  if (passwordController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'must be input password';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() ==
                                      true) {
                                    BlocProvider.of<AuthCubit>(context).login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                minWidth: double.infinity,
                                color: Colors.deepOrange,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(state is LoginLoadingState
                                    ? 'Loading...'
                                    : 'Login'),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black)),
                                  SizedBox(width: 4,),
                                  InkWell(
                                    onTap: ()
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                    },
                                    child: const Text('Create one',style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              );
            },
          )),
    );
  }
}
