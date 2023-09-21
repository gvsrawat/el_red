///this class contains response codes for http requests
abstract class HttpResponseCodes {
  static const int ok = 200;
  static const int created = 201;
  static const int SE = 500;
  static const int notAuthorized = 401;
  static const int forbidden = 403;

  ///for all the other errors.
  static const int customErrorCode = 16100;
}

///class for http request methods.
abstract class HttpRequestMethods {
  static const String get = "GET";
  static const String post = "POST";
}
