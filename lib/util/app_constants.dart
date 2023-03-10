class AppConstants{
  static const String APP_NAME ="Food Delivery";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://192.168.1.84:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMEND_PRODUCT_URI = "/api/v1/products/recommended";

  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO = "/api/v1/customer/info";

  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS ="/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI ="/api/v1/customer/address/list";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";

  static const String PLACE_ORDER_URI = "/api/v1/customer/order/place";
  static const String ORDER_LIST_URI = "/api/v1/customer/order/list";

  static const String TOKEN = "";
  static const String PHONE = "phone_number";
  static const String PASSWORD = "user_password";
  static const String cartList = "Cart List";
  static const String cartHistory = "Cart List History";
}