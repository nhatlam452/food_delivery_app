import 'package:food_delivery_app/data/response/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/response/recommended_product_repo.dart';
import '../model/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductResponse recommendedProductResponse;

  RecommendedProductController({required this.recommendedProductResponse});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductResponse.getRecommendedProductList();
    if (response.statusCode == 200) {

      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); //like setState
    } else {}
  }
}
