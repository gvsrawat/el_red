import 'dart:io';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:image_cropper/image_cropper.dart';

///base image cropper class
abstract class ImgCropper {
  Future<File?> cropImage(File imageFile);
}

///concrete implementation for image cropping for mobile device(android, iOS),
/// different implementations can be achieved for other platforms(web,desktop) using ImgCropper base class.
class MobileImageCropper extends ImgCropper {
  @override
  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 25,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: ElStrings.editPhoto,
            toolbarColor: ElColors.whiteColor,
            toolbarWidgetColor: ElColors.blackColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    return croppedFile?.path != null ? File(croppedFile!.path) : null;
  }
}
