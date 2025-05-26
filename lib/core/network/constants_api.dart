class ConstantsApi {
  static String baseUrl = "https://tzawd.com/api/";

  // Api Onboarding
  static String onboardingUrl = "onboarding-screens";

  //Api Auth
  static String registerUrl = "buyer/register";
  static String loginUrl = "buyer/login";
  static String logoutUrl = "buyer/logout";
  static String verifyOtpUrl = "buyer/verify-otp";
  static String forgotPasswordUrl = "buyer/forgot-password";
  static String resetPasswordUrl = "buyer/reset-password";
  static String changePasswordUrl = "buyer/change-password";
  static String profileDetailsUrl = "buyer/me";

  //Api Category
  static String getCategoriesUrl = "categories";

  static String getCategoryDetailsUrl(int id) => "categories/$id";

  // Api Product
  static String getProductsUrl = "products";

  static String getProductDetailsUrl(int id) => "products/$id";

  // Api Favorites
  static String getFavoriteProductsUrl = "buyer/favorites";
  static String addProductToFavoritesUrl = "buyer/favorites";

  static String removeProductFromFavoritesUrl(int id) => "buyer/favorites/$id";

  // Search & Filter
  static String filterProducts = "products/filter";
}
