import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/modules/screens/Auth_screens/Auth_cubit/auth_state.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  void register(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    emit(RegisterLoadingState());
    Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/register'),
      body: {
        'name': name,
        "email": email,
        'password': password,
        'phone': phone,
      },
      headers: {'lang': 'en'},
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      emit(RegisterSuccessState());
    } else {
      emit(FieldToRegisterState(message: responseBody["message"]));
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try{
      Response response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/login'),
          body: {
            'email':email,
            'password':password,
          },
          headers: {
            'lang':'en'
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        if(data['status'] == true){
        await CacheNetwork.insertToCache(key: 'token', value: data['data']['token']);
          emit(LoginSuccessState());
        }else{
          emit(FieldToLoginState(message:data['message']));
        }
      }
    }catch(e){
      emit(FieldToLoginState(message:e.toString()));
    }
  }
}
