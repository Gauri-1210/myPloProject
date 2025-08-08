class APIEndPoint {
  static String serverURL = "https://myplo.itworkshop.in/";

  //auth
  static String login = "user/userLogin";
  static String signup = "user/userSignup";
  static String verifyEmail = "user/verifyEmail";
  static String emailRequest = "user/verifyEmailRequest";
  static String otpRequest = "user/requestOtp";
  static String changePassword = "user/changePassword";
  static String changeProfilePassword = "user/changeProfilePassword";

  //bottom navigation bar
  static String appHomeData = "user/appHomedata";
  static String subCategorybyId = "user/getSubcategoryByCategoryId";
  static String userData = "user/getUserData";
  static String changeprofilepassword = "user/changeProfilePassword";
  static String userdashboarddata = "user/userDashboard";
  static String activecategories = "admin/getActiveCategories";
  static String shippingSize = "admin/getShippingSizes";
  static String addOrUpdateProduct = "admin/addOrUpdateProduct";
  static String getUserAddress = "user/getUserAddresses";
  static String addOrUpdateAddress = "user/addOrUpdateAddress";
  static String softDeleteAddress = "user/softDeleteAddress";
  static String calculateShippingRate = "user/calculateShippingRate";
  static String googleApiKey = "AIzaSyCMaAYUw0D5pVc9_m73MogYVeYLH3BDnhU";

  //Payment
  static String createPaymentInstant = "user/createPaymentInstant";
  static String createBooking = "admin/createBooking";
  static String createOrder = "user/createOrder";
  static String checkStripeAccountStatus = "/user/checkStripeAccountStatusApp";
  static String stripeVarificationLink = "/user/stripeVarificationLink";
  //user
  static String verifyEmailRequest = "user/verifyEmailRequest";
}
