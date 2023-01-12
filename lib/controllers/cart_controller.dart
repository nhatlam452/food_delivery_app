import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/response/cart_repo.dart';
import 'package:food_delivery_app/model/products_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';
import '../util/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get item => _items;
  List<CartModel> storageItems = []; //for storage and sharePreferences
  void addItem(ProductModel productModel, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExit: true,
            time: DateTime.now().toString(),
            product: productModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              quantity: quantity,
              isExit: true,
              time: DateTime.now().toString(),
              product: productModel);
        });
      } else {
        Get.snackbar(
            "Item count", "Your should have at least 1 item to add in cart !",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool exitsInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }
  List<CartModel> getCartHistoryList(){
    return cartRepo.getHistoryList();
  }
  set setItems(Map<int,CartModel> setItems){
    _items = {};
    _items = setItems;
  }
  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }
}
