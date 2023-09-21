import 'dart:io';
import 'package:el_red/business/handlers/image_cropper_handler.dart';
import 'package:el_red/business/repositories/file_repo.dart';
import 'package:el_red/presentation/image_oper_views/image_picker_option.dart';
import 'package:flutter/cupertino.dart';

///this class handles the business logic for file uploading.
class FileUploadProvider extends ChangeNotifier {
  ///to determine the state of file upload i.e (upload in progress || not).
  bool _fileUploadInProgress = false, _fetchingBannerImage = false;

  ///selected image as file.
  File? _selectedImage;

  ///getter for selected image
  File? get selectedFile => _selectedImage;

  ///setter for selected image
  void setSelectedFile(File? image) {
    _selectedImage = image;
  }

  ///to display file upload progress.
  double? _fileUploadProgress;

  ///getter file upload progress.
  double? get fileUploadProgress => _fileUploadProgress;

  ///getter for file uploading status
  bool get isUploading => _fileUploadInProgress;

  ///getter for banner details fetching status
  bool get fetchingBannerImage => _fetchingBannerImage;

  ///setter for banner details fetching status
  void setBannerImageLoadingFlag(bool isLoading) {
    _fetchingBannerImage = isLoading;
  }

  ///file repo instance
  final FileUploadRepo _fileUploadRepo = FileUploadRepo();

  ///helper method to upload an image on server via repository.this method accepts a file.
  Future<bool> uploadImage(File imageFile) async {
    _fileUploadProgress = 0;
    _fileUploadInProgress = true;
    notifyListeners();
    var result = await _fileUploadRepo.uploadImage(imageFile,
        progressUpdate: (double? progress) =>
            fileUploadProgressSetter(progress));
    _fileUploadInProgress = false;
    _fileUploadProgress = 0;
    notifyListeners();
    return Future.value(result?.success == true &&
        result?.result?.isNotEmpty == true &&
        result!.result!.first.profileBannerImageURL != null);
  }

  ///helper method to choose the image handler.
  void selectImageOptions(BuildContext context, {Function? onSelectionDone}) {
    ElImagePicker.showFilePickerSheet(
        context: context,
        onSelectionDone: (File imageFile) =>
            openImageCropper(imageFile, onSelectionDone: onSelectionDone));
  }

  ///helper method to call the image crop handler.
  void openImageCropper(File imageFile, {Function? onSelectionDone}) {
    MobileImageCropper().cropImage(imageFile).then((croppedImage) {
      if (croppedImage != null) {
        _selectedImage = croppedImage;
        if (onSelectionDone != null) {
          onSelectionDone();
          return;
        }
      }
    });
  }

  ///helper method to fetch image from server.
  Future<String?> getBannerImage({bool shouldUpdateUi = false}) async {
    _fetchingBannerImage = true;
    if (shouldUpdateUi) {
      notifyListeners();
    }
    await _fileUploadRepo.getBannerImage();
    _fetchingBannerImage = false;
    if (shouldUpdateUi) {
      notifyListeners();
    }
    return Future.value(_fileUploadRepo.savedPictureUrlInBackend);
  }

  ///to update the listeners.
  void updateUi() {
    notifyListeners();
  }

  void fileUploadProgressSetter(double? fileProgress) {
    _fileUploadProgress = fileProgress;
    notifyListeners();
  }
}
