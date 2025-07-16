class ConstantsApi {
  static String get baseUrl => "https://tzawd.com/api/v1/"; //https://tzawd.com/api/v1

  // Api Onboarding
  static String get onboardingUrl => "onboarding-screens";

  //Api Auth
  static String get registerUrl => "auth/register";

  static String get loginBuyerUrl => "auth/buyer/login";

  static String get loginSupplierUrl => "auth/supplier/login";

  static String get logoutUrl => "auth/logout";

  static String get verifyOtpUrl => "auth/verify-otp";

  static String get forgotPasswordUrl => "auth/forgot-password";

  static String get resetPasswordUrl => "auth/reset-password";

  static String get changePasswordUrl => "auth/change-password";

  static String get deleteAccountUrl => "auth/delete-account";

  static String get profileDetailsUrl => "auth/me";

  // Api Ads
  static String get getAdsUrl => "ads";

  //Api Category
  static String get getCategoriesUrl => "categories";

  static String getCategoryDetailsUrl(int id) => "buyer/categories/$id";

  // Api Product
  static String get getProductsUrl => "buyer/products";

  static String getProductDetailsUrl(int id) => "buyer/products/$id";

  static String getProductsRelatedUrl(int id) => "buyer/products/$id/related";

  // Api Favorites
  static String get getFavoriteProductsUrl => "buyer/favorites";

  static String get addProductToFavoritesUrl => "buyer/favorites";

  static String removeProductFromFavoritesUrl(int id) => "buyer/favorites/$id";

  // Search & Filter
  static String filterProducts = "buyer/products/filter";

  // Cart
  static String get getCartUrl => "buyer/cart";

  static String get addProductToCartUrl => "buyer/cart/add";

  static String removeProductFromCartUrl(int id) => "buyer/cart/items/$id";

  static String updateProductQuantityUrl(int id) => "buyer/cart/items/$id/quantity";

  static String get checkoutUrl => "buyer/orders_buyer/checkout";

  // Orders
  static String get getOrdersUrl => "buyer/orders_buyer";

  static String get getSupplierOrders => "supplier/orders?shipping_method=1";

  static String get getSupplierFields => "fields/supplier";

  static String getOrderDetailsUrl(int id) => "buyer/orders_buyer/$id";

  static String get getSuppliers => "suppliers";

  static String getSupplierCategories(int supplierId) => "supplier/$supplierId/categories";

  static String getSupplierProducts(int supplierId) => "supplier/$supplierId/products";

  static String get getCart => "cart";

  static String get addToCart => "cart";

  static String removeFromCart(int id) => "cart/$id";

  static String get clearCart => "cart/clear";

  static String get getProductsSupplierUrl=>"products";

  static String get addProductSupplierUrl => "products";

  static String removeProductSupplierUrl(String id) => "/products/$id";

  static String editProductSupplierUrl(String id) => "/products/$id";
}
