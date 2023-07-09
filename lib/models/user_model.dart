import 'package:flutter/material.dart';

class UserModel{
  String? name;
  String? phone;
  String ?email;
  String? image;
  String? token;
  UserModel({ this.name,this.token,this.email,this.image,this.phone});
  UserModel.fromJson({required Map<String,dynamic>data}){
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name' : name,
      'email':email,
      'phone':phone,
      'image':image,
      'token':token
    };
  }
}