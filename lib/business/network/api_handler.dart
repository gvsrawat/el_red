import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:el_red/business/network/api_urls_and_keys.dart';
import 'package:el_red/business/network/http_response_codes.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/models/common_response_model.dart';

///base class for api handling
abstract class ApiHandler {
  Future<CommonResponseModel> request(
      {required final String url,
      Map<String, dynamic>? bodyData,
      required final String httpMethodType});
}

///ssl certificate overriding/by-passing
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

///this class handles the http request using single "request" method.
///method type,body data and url are the parameters that this(request) method accepts.
class ApiClient extends ApiHandler {
  static ApiClient? _instance;

  ///singleton
  factory ApiClient() {
    return _instance ?? ApiClient._init();
  }

  final Map<String, dynamic> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${ElToken.apiToken}",
  };

  ApiClient._init();

  final Dio _dio = Dio();

  @override
  Future<CommonResponseModel> request(
      {required final String url,
      dynamic bodyData,
      required final String httpMethodType,
      Function(double?)? progressUpdate}) async {
    CommonResponseModel? commonResponseModel;
    Response? response;
    try {
      response = await _dio.requestUri(Uri.parse(url),
          options: Options(method: httpMethodType, headers: headers),
          data: bodyData, onSendProgress: (int sent, int total) {
        if (progressUpdate != null) {
          progressUpdate((sent / total * 100));
        }
      });
      if (response.statusCode != null &&
              response.statusCode == HttpResponseCodes.ok ||
          response.statusCode == HttpResponseCodes.created) {
        var decodedJson = json.decode(response.toString());
        commonResponseModel = CommonResponseModel(
            statusCode: response.statusCode!,
            responseData: decodedJson,
            success: true);
      }
    } catch (err) {
      commonResponseModel = CommonResponseModel(
          statusCode: response?.statusCode ?? HttpResponseCodes.customErrorCode,
          responseData: null,
          success: false,
          errorMessage: ElStrings.errorMessage +
              (response?.statusCode ?? HttpResponseCodes.customErrorCode)
                  .toString());
    }
    return commonResponseModel!;
  }
}
