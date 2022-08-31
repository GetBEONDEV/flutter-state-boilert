class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrlLogin = "https://api.maxidescuentos.co/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String loginUser = "$baseUrlLogin/api/v1/auth/login";
}
