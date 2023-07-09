import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/banners_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/modules/screens/cart_screen.dart';
import 'package:ecommerce_app/modules/screens/category_screen.dart';
import 'package:ecommerce_app/modules/screens/favoriet_screen.dart';
import 'package:ecommerce_app/modules/screens/home_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/Profile_Screen.dart';
import 'package:ecommerce_app/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../models/producr_model.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  void changeNavIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  UserModel? userModel;
  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/profile'), headers: {
      'Authorization': token!,
      "lang": "en",
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);
      print('response is $responseData');
      emit(GetUserDataSuccessState());
    } else {
      print('response is $responseData');
      emit(FieldToGetUserDataState(error: responseData['message']));
    }
  }

  List<BannersModel> banners = [];

  void getBannersData() async {
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/banners'),
        headers: {'lang': 'en'});

    final responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannersModel.fromJson(data: item));
      }
      emit(GetBannersDataLoadingState());
    } else {
      emit(FieldGetBannersDataState());
    }
  }

  List<CategoryModel> categories = [];

  void getCategoryData() async {
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/categories'),
        headers: {'lang': 'en'});

    final responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategoryDataSuccessState());
    } else {
      emit(FieldGetCategoryDataState());
    }
  }

  List<ProductModel> products = [];
  void getProducts() async {
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/home'),
        headers: {'Authorization': token!, 'lang': 'en'});

    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(ProductModel.fromJson(data: item));
        emit(GetProductsSuccessState());
      }
    } else {
      emit(FieldGetProductsState());
    }
  }

  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProductsSuccessState());
  }

  List<ProductModel> favorites = [];
  Set<String> favoritesId = {};
  Future<void> getFavorites() async {
    favorites.clear();
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'lang': 'en', 'Authorization': token!});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        //ProductModel.fromJson(data: item['product']);
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoritesId.add(item['product']['id'].toString());
      }
      emit(GetFavoritesSuccessState());
    } else {
      emit(FieldGetFavoritesState());
    }
  }

  void addOrRemoveFromFavorites({required String productId}) async {
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'lang': 'en', 'Authorization': token!},
        body: {"product_id": productId});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoritesId.contains(productId) == true) {
        favoritesId.remove(productId);
      } else {
        favoritesId.add(productId);
      }
      await getFavorites();
      emit(AddOrRemoveFromFavoritesSuccess());
    } else {
      emit(FieldAddOrRemoveFromFavorites());
    }
  }

  List<ProductModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  Future<void> getCarts() async {
    carts.clear();
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      headers: {'lang': 'en', 'Authorization': token!},
    );
    var responseBody = jsonDecode(response.body);
    totalPrice = responseBody['data']['total'].toInt();
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['cart_items']) {
        cartsId.add(item['product']['id'].toString());
        carts.add(ProductModel.fromJson(data: item['product']));
      }

      emit(GetCartsSuccessState());
    } else {
      emit(FieldToGetCartsState());
    }
  }

  void addOrRemoveFromCarts({required String id}) async {
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {'lang': 'en', 'Authorization': token!},
        body: {"product_id": id});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (cartsId.contains(id) == true) {
        cartsId.remove(id);
      } else {
        cartsId.add(id);
      }
      await getCarts();
      emit(AddOrRemoveFromCartsSuccess());
    } else {
      emit(FieldAddOrRemoveFromCarts());
    }
  }
}
