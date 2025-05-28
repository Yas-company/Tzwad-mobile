class ConstantsApi {
  static String get baseUrl => "https://tzawd.com/api/";

  // Api Onboarding
  static String get onboardingUrl => "onboarding-screens";

  //Api Auth
  static String get registerUrl => "buyer/register";

  static String get loginUrl => "buyer/login";

  static String get logoutUrl => "buyer/logout";

  static String get verifyOtpUrl => "buyer/verify-otp";

  static String get forgotPasswordUrl => "buyer/forgot-password";

  static String get resetPasswordUrl => "buyer/reset-password";

  static String get changePasswordUrl => "buyer/change-password";

  static String get deleteAccountUrl => "buyer/delete-account";

  static String get profileDetailsUrl => "buyer/me";

  //Api Category
  static String get getCategoriesUrl => "categories";

  static String getCategoryDetailsUrl(int id) => "categories/$id";

  // Api Product
  static String get getProductsUrl => "products";

  static String getProductDetailsUrl(int id) => "products/$id";

  static String getProductsRelatedUrl(int id) => "products/$id/related";

  // Api Favorites
  static String get getFavoriteProductsUrl => "buyer/favorites";

  static String get addProductToFavoritesUrl => "buyer/favorites";

  static String removeProductFromFavoritesUrl(int id) => "buyer/favorites/$id";

  // Search & Filter
  static String filterProducts = "products/filter";

  // Cart
  static String get getCartUrl => "buyer/cart";

  static String get addProductToCartUrl => "buyer/cart/add";

  static String removeProductFromCartUrl(int id) => "buyer/cart/items/$id";

  static String updateProductQuantityUrl(int id) => "buyer/cart/items/$id/quantity";

  static String get checkoutUrl => "buyer/orders/checkout";

  // Orders
  static String get getOrdersUrl => "buyer/orders";

  static String getOrderDetailsUrl(int id) => "buyer/orders/$id";
}
