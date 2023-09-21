import 'package:dotted_border/dotted_border.dart';
import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:el_red/business/repositories/file_repo.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_const_sizes.dart';
import 'package:el_red/business/utils/el_image_paths.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/business/utils/extennsions.dart';
import 'package:el_red/business/utils/toasts.dart';
import 'package:el_red/models/user_model.dart';
import 'package:el_red/presentation/image_oper_views/profile_avatar_widget.dart';
import 'package:el_red/presentation/image_oper_views/zoomable_widget.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///this screen holds the logic for panning and zooming of an Image.
///Images can also be uploaded from this screen.
class CustomiseCardPanZoom extends StatelessWidget {
  CustomiseCardPanZoom({super.key});

  late FileUploadProvider _fileUploadProvider;

  @override
  Widget build(BuildContext context) {
    _fileUploadProvider = Provider.of<FileUploadProvider>(context);
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async {
            if (_fileUploadProvider.isUploading ||
                _fileUploadProvider.fetchingBannerImage) {
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            backgroundColor: ElColors.whiteColor,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonAppBar(
                    title: ElStrings.customiseYourCard,
                    onTrailingIconTap: () {
                      if (_fileUploadProvider.isUploading ||
                          _fileUploadProvider.fetchingBannerImage) {
                        return;
                      }
                      Navigator.pop(context);
                    },
                    trailingIcon: const Icon(Icons.close),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: ElSizes.getCommonScreenPadding(),
                            child: CustomizeButton(
                                onButtonTap: () => _fileUploadProvider
                                    .selectImageOptions(context,
                                        onSelectionDone: () =>
                                            _fileUploadProvider.updateUi()))),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 16),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: ZoomWidget(
                                      isZoomAble: true,
                                      child: _fileUploadProvider.selectedFile !=
                                              null
                                          ? Image.file(
                                              _fileUploadProvider.selectedFile!,
                                              fit: BoxFit.cover)
                                          : CachedNetImage(
                                              imageUrl: FileUploadRepo()
                                                      .savedPictureUrlInBackend ??
                                                  '',
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 65,
                                    child: IgnorePointer(
                                      ignoring: true,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const ProfileImageHolder(
                                                hasImage: false),
                                            24.heightBox,
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(userModel.userName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          ElColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                4.heightBox,
                                                Text(userModel.secondName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          ElColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                30.heightBox,
                                                Text(userModel.role,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: ElColors
                                                            .whiteColor)),
                                                5.heightBox,
                                                Text(userModel.location,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ElColors
                                                            .whiteColor))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        11.heightBox,
                        Container(
                          margin: ElSizes.getCommonScreenPadding(),
                          child: CommonActionButton(
                              buttonName: ElStrings.save,
                              buttonColor: ElColors.buttonRedColor,
                              cornerRadius: 100,
                              borderWidth: 1,
                              onButtonTap: () {
                                _onSaveTap(context);
                              },
                              borderColor: ElColors.transparentColor,
                              buttonTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ElColors.whiteColor,
                                  fontSize: 20)),
                        ),
                        35.heightBox,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (_fileUploadProvider.isUploading ||
            _fileUploadProvider.fetchingBannerImage)
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
                      progressInfo: (_fileUploadProvider.fileUploadProgress ==
                                  null ||
                              _fileUploadProvider.fileUploadProgress == 0)
                          ? null
                          : "${_fileUploadProvider.fileUploadProgress?.toStringAsFixed(2)}",
                    )),
              ))
      ],
    );
  }

  ///method to save zoom levels for other pages.
  ///If user has not selected new image then only sets the new zoom level otherwise,
  ///If user has selected new image then firstly that image is uploaded to backend and then we do fetch the same image
  ///and then user is redirected to previous screen, there user will see old image with zoom levels(if set by user).
  void _onSaveTap(BuildContext context) async {
    onSuccess() {
      Provider.of<ZoomProvider>(context, listen: false)
          .updateZoomLevelOnSaveClick();
      Navigator.pop(context, true);
    }

    if (_fileUploadProvider.selectedFile != null) {
      bool firstApiSucceed = await _fileUploadProvider
          .uploadImage(_fileUploadProvider.selectedFile!);
      if (firstApiSucceed) {
        String? bannerImageUrl =
            await _fileUploadProvider.getBannerImage(shouldUpdateUi: true);
        if (bannerImageUrl?.trim().isNotEmpty == true) {
          onSuccess();
          showToast(
              message: ElStrings.imageUploadedSuccessMessage, isPositive: true);
        } else {
          showToast(message: ElStrings.errorMessage, isPositive: false);
        }
      } else {
        showToast(
            message: ElStrings.imageUploadFailedMessage, isPositive: false);
      }
    } else {
      onSuccess();
    }
  }
}

///widget for file upload option button.
class CustomizeButton extends StatelessWidget {
  const CustomizeButton({super.key, required this.onButtonTap});

  final Function onButtonTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTap();
      },
      onDoubleTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: DottedBorder(
          radius: const Radius.circular(8),
          dashPattern: const [4, 3],
          color: ElColors.lightBlueColor,
          borderType: BorderType.RRect,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ElColors.changePictureCardInnerColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SvgImageHolder(
                  image: ElImages.imageIconSvg,
                  height: 26,
                  width: 20,
                ),
                8.widthBox,
                const Flexible(
                  child: Text(ElStrings.changePictureHereAndAdjust,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ElColors.greyTextColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
