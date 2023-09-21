import 'dart:io';
import 'package:el_red/models/banner_image_details_model.dart';
import 'package:el_red/models/file_upload_reponse_model.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:dio/dio.dart';
import 'package:el_red/business/network/api_handler.dart';
import 'package:el_red/business/network/api_urls_and_keys.dart';
import 'package:el_red/business/network/http_response_codes.dart';

///helper repository class to upload an image on server.
/// purpose of this class is to achieve loose coupling of Provider on network layer.
class FileUploadRepo {
  static FileUploadRepo? _fileUploadRepo;

  ///singleton
  factory FileUploadRepo() {
    return _fileUploadRepo ??= FileUploadRepo._init();
  }

  FileUploadRepo._init();

  ///url caching
  String? _uploadedImage;

  ///getter for saved url
  String? get savedPictureUrlInBackend => _uploadedImage;

  ///user uploaded url setter.
  void setSavedPictureUrl(String? url) {
    _uploadedImage = url;
  }

  ///helper method to upload an image on server using network layer.
  ///it accepts the file parameter.
  Future<FileUploadResponse?> uploadImage(final File imageFile,
      {Function(double?)? progressUpdate}) async {
    FileUploadResponse? fileUploadResponse;
    try {
      var formData = FormData.fromMap({
        "profileBannerImageURL": await MultipartFile.fromFile(imageFile.path,
            contentType: MediaType("image", imageFile.path.split(".").last))
      });
      var response = await ApiClient().request(
          url: ElUrls.fileUploadUrl,
          httpMethodType: HttpRequestMethods.post,
          bodyData: formData,
          progressUpdate: progressUpdate);

      if (response.success && response.responseData != null) {
        fileUploadResponse = FileUploadResponse.fromJson(response.responseData);
      }
    } catch (e) {
      // TODO
    }
    return fileUploadResponse;
  }

  ///helper method to fetch image from server.
  Future<BannerDetailsResponse?> getBannerImage() async {
    BannerDetailsResponse? bannerDetailsResponse;
    try {
      var response = await ApiClient().request(
          url: ElUrls.fetchInfoUrl,
          httpMethodType: HttpRequestMethods.post,
          bodyData: {"cardImageId": ElToken.cardId});

      if (response.success && response.responseData != null) {
        bannerDetailsResponse =
            BannerDetailsResponse.fromJson(response.responseData);
        if (bannerDetailsResponse.result?.isNotEmpty == true &&
            bannerDetailsResponse.result!.first.customImageCardDesignInfo
                    ?.profileBannerImageURL !=
                null) {
          _uploadedImage = bannerDetailsResponse
              .result!.first.customImageCardDesignInfo?.profileBannerImageURL;
        }
      }
    } catch (e) {
      //TODO
    }
    return bannerDetailsResponse;
  }
}
