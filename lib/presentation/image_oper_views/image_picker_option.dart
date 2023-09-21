import 'dart:io';
import 'package:el_red/business/handlers/file_picker_hanlder.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_image_paths.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';

///provides the picker options i.e (camera, gallery) via bottom-sheet.
abstract class ElImagePicker {
  static Future showFilePickerSheet(
      {required BuildContext context,
      required Function(File) onSelectionDone}) {
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ImageFromCamera().pickImage().then((image) {
                        if (image != null) {
                          onSelectionDone(File(image.path));
                        }
                      });
                    },
                    onDoubleTap: () {},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgImageHolder(image: ElImages.pickCameraSvg),
                        SizedBox(height: 5),
                        Text(ElStrings.cameraText,
                            style: TextStyle(
                                color: ElColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ImageFromGallery().pickImage().then((image) {
                        if (image != null) {
                          onSelectionDone(File(image.path));
                        }
                      });
                    },
                    onDoubleTap: () {},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgImageHolder(image: ElImages.pickGallerySvg),
                        SizedBox(height: 5),
                        Text(ElStrings.galleryText,
                            style: TextStyle(
                                color: ElColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
