import 'package:image_picker/image_picker.dart';

///base image picker abstract class, to make features/classes loosely coupled + easy testable.
abstract class ImgPicker {
  Future<XFile?> pickImage();
}

///concrete implementation for image picker(mobile camera).
class ImageFromCamera extends ImgPicker {
  final _imagePicker = ImagePicker();

  @override
  Future<XFile?> pickImage() {
    return _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 25);
  }
}

///concrete implementation for image picker(mobile gallery).
class ImageFromGallery extends ImgPicker {
  final _imagePicker = ImagePicker();

  @override
  Future<XFile?> pickImage() {
    return _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
  }
}
