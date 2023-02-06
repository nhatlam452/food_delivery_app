import 'dart:convert';

import 'package:food_delivery_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    var time = DateTime.now();
    cartList.forEach((element){
      element.time =  time.toString();
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cartList, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
  List<CartModel> getHistoryList(){
    if (sharedPreferences.containsKey(AppConstants.cartHistory)) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }
    List<CartModel> cartList = [];

    cartHistory.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
  void addToCartHistory(){
    if (sharedPreferences.containsKey(AppConstants.cartHistory)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }
    for(int i = 0; i<cart.length ; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cartHistory,cartHistory);

  }
  void removeCart() {
    cart =[];
    sharedPreferences.remove(AppConstants.cartList);
  }
  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.cartHistory);

  }
}


