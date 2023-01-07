import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/response/popular_product_repo.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';
import '../model/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductResponse popularProductResponse;

  PopularProductController({required this.popularProductResponse});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItem = 0;

  int get inCartItem => _inCartItem + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductResponse.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product
          .fromJson(response.body)
          .products);
      _isLoaded = true;
      update(); //like setState
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if (_inCartItem+quantity == 20) {
        Get.snackbar("Item count", "You can't add more !",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
        return;
      }
      _quantity = _quantity + 1;
    } else {
      if (_inCartItem+quantity == 0) {
        Get.snackbar("Item count", "You can't reduce more !",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
        return;
      }
      _quantity = _quantity - 1;
    }
    update();
  }

  void initProduct(ProductModel product, CartController cartController) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cartController;
    var exist = false;
    exist = _cart.exitsInCart(product);
    if (exist) {
      _inCartItem = _cart.getQuantity(product);
    }
    print("Quantity in the cart is " + _inCartItem.toString());
  }

  void addItem(ProductModel productModel) {
    // if (_inCartItem + quantity > 0) {
      _cart.addItem(productModel, _quantity);
      _quantity = 0;
      _inCartItem = _cart.getQuantity(productModel);
    // } else {
    //   Get.snackbar(
    //       "Item is 0", "Your should have at least 1 item to add in cart",
    //       backgroundColor: AppColors.mainColor, colorText: Colors.white);
    // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
