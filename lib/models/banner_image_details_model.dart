///user banner image response model.
class BannerDetailsResponse {
  final bool? success;
  final bool? isAuth;
  final String? message;
  final List<Result>? result;

  BannerDetailsResponse(
      {required this.success,
      required this.isAuth,
      required this.message,
      required this.result});

  factory BannerDetailsResponse.fromJson(Map<String, dynamic> json) {
    List<Result> result = [];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
    return BannerDetailsResponse(
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
  final CustomImageCardDesignInfo? customImageCardDesignInfo;

  Result({this.customImageCardDesignInfo});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        customImageCardDesignInfo: json['customImageCardDesignInfo'] != null
            ? CustomImageCardDesignInfo.fromJson(
                json['customImageCardDesignInfo'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customImageCardDesignInfo != null) {
      data['customImageCardDesignInfo'] = customImageCardDesignInfo!.toJson();
    }
    return data;
  }
}

class CustomImageCardDesignInfo {
  final String? profileBannerImageURL;

  CustomImageCardDesignInfo({required this.profileBannerImageURL});

  factory CustomImageCardDesignInfo.fromJson(Map<String, dynamic> json) {
    return CustomImageCardDesignInfo(
        profileBannerImageURL: json['profileBannerImageURL'] as String?);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileBannerImageURL'] = profileBannerImageURL;
    return data;
  }
}
