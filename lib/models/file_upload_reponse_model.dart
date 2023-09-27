///image upload response model.
class FileUploadResponse {
  final bool? success;
  final bool? isAuth;
  final String? message;
  final List<Result>? result;

  FileUploadResponse(
      {required this.success,
      required this.isAuth,
      required this.message,
      required this.result});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    List<Result> result = [];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
    return FileUploadResponse(
        success: (json['success'] as bool?),
        isAuth: (json['isAuth'] as bool?),
        message: (json['message'] as String?),
        result: result);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['isAuth'] = isAuth;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  final String? uid;
  final String? profileBannerImageURL;

  Result({required this.uid, required this.profileBannerImageURL});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        uid: json['uid'] as String?,
        profileBannerImageURL: json['profileBannerImageURL'] as String?);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['profileBannerImageURL'] = profileBannerImageURL;
    return data;
  }
}
