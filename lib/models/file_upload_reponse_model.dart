///image upload response model.
class FileUploadResponse {
  bool? success;
  bool? isAuth;
  String? message;
  List<Result>? result;

  FileUploadResponse({this.success, this.isAuth, this.message, this.result});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    isAuth = json['isAuth'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['isAuth'] = this.isAuth;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? uid;
  String? profileBannerImageURL;

  Result({this.uid, this.profileBannerImageURL});

  Result.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    profileBannerImageURL = json['profileBannerImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['profileBannerImageURL'] = this.profileBannerImageURL;
    return data;
  }
}
