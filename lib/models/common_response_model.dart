///common Response model that'll handle api responses from network layer.
class CommonResponseModel {
  dynamic responseData;
  final int statusCode;
  final String? errorMessage;
  final bool success;

  CommonResponseModel(
      {this.responseData,
      required this.statusCode,
      this.errorMessage,
      required this.success});
}
