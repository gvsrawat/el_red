import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:el_red/business/repositories/file_repo.dart';
import 'package:el_red/business/utils/custom_page_transition.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_const_sizes.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/business/utils/extennsions.dart';
import 'package:el_red/business/utils/toasts.dart';
import 'package:el_red/presentation/image_oper_views/user_details_view.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadPictureScreen extends StatelessWidget {
  UploadPictureScreen({super.key});

  late FileUploadProvider _fileUploadProvider;

  @override
  Widget build(BuildContext context) {
    _fileUploadProvider = Provider.of<FileUploadProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (_fileUploadProvider.isUploading) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ElColors.whiteColor,
            body: SafeArea(
              child: Column(
                children: [
                  CommonAppBar(
                    title: ElStrings.uploadPictureText,
                    onLeadingIconTap: () => Navigator.pop(context),
                    leadingIcon: const Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Container(
                      margin: ElSizes.getCommonScreenPadding(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                width: double.infinity,
                                child: _fileUploadProvider.selectedFile != null
                                    ? FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.file(
                                            _fileUploadProvider.selectedFile!,
                                            fit: BoxFit.contain),
                                      )
                                    : const SizedBox.shrink(),
                              )),
                              10.heightBox,
                              const Text(ElStrings.pictureReadyToBeSavedText,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ElColors.greyTextColor)),
                              66.heightBox,
                            ],
                          )),
                          CommonActionButton(
                              buttonName: ElStrings.saveAndContinueText,
                              buttonColor: ElColors.buttonRedColor,
                              cornerRadius: 100,
                              onButtonTap: () => _onFileSave(context),
                              buttonTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ElColors.whiteColor,
                                  fontSize: 20)),
                          32.heightBox,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_fileUploadProvider.isUploading)
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                      color: ElColors.transparentColor,
                      alignment: Alignment.center,
                      child: ProgressBar(
                          progressInfo:
                              "${_fileUploadProvider.fileUploadProgress?.toStringAsFixed(2)}")),
                ))
        ],
      ),
    );
  }

  //helper method to save the file, accepts BuildContext as argument.
  void _onFileSave(BuildContext context) async {
    onBack() {
      //clearing caches
      FileUploadRepo().setSavedPictureUrl(null);
      Provider.of<ZoomProvider>(context, listen: false).clearCache();
      Navigator.pop(context);
    }

    //context might be removed from widget tree, so keeping a function call beforehand.
    onSuccess() {
      //removing saved image file locally,and sending user to initial screen.
      _fileUploadProvider.setSelectedFile(null);
      Navigator.push(context, getCustomPageRoute(const UserDetailsScreen()))
          .then((value) {
        onBack();
      });
    }

    bool fileUploaded = await _fileUploadProvider
        .uploadImage(_fileUploadProvider.selectedFile!);
    if (fileUploaded) {
      onSuccess();
      showToast(message: ElStrings.imageUploadedSuccessMessage);
    } else {
      showToast(message: ElStrings.imageUploadFailedMessage, isPositive: false);
    }
  }
}
