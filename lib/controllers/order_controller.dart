import 'package:food_delivery_app/data/response/OrderRepo.dart';
import 'package:food_delivery_app/model/order_model.dart';
import 'package:food_delivery_app/model/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  List<OrderModel> get historyOrderList => _historyOrderList;

  List<OrderModel> get currentOrderList => _currentOrderList;

  Future<void> placeOrder(PlaceOrderBody placeOrderBody) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrderBody);
    if (response.statusCode == 200) {
      _isLoading = false;
      print("success");
    } else {
      print("failed");
    }
  }

  Future<void> getOrderList() async {
    print("loading");
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];

      (response.body as List).forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    update();
    print("code : " + response.statusCode.toString());
    print("length : " + _currentOrderList.length.toString());
    print("length 1 : " + _historyOrderList.length.toString());
    print("length 2 : " + response.body.length.toString());
  }
}
