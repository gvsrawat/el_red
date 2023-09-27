import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:el_red/business/repositories/file_repo.dart';
import 'package:el_red/business/utils/custom_page_transition.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_const_sizes.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/business/utils/extennsions.dart';
import 'package:el_red/models/user_model.dart';
import 'package:el_red/presentation/image_oper_views/customise_card_pan_zoom.dart';
import 'package:el_red/presentation/image_oper_views/profile_avatar_widget.dart';
import 'package:el_red/presentation/image_oper_views/zoomable_widget.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///this class provides the option for user to navigate to pan and zoom screen.
///If user sets new zoom measurements then same will be reflected here on this screen.
class CustomiseYourCardScreen extends StatelessWidget {
  const CustomiseYourCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FileUploadProvider>(context);
    return Scaffold(
      backgroundColor: ElColors.greyBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CommonAppBar(
              title: ElStrings.customImageCard,
              onLeadingIconTap: () => Navigator.pop(context),
              leadingIcon: const Icon(Icons.arrow_back_ios),
            ),
            Expanded(
                child: Container(
              margin: ElSizes.getCommonScreenPadding(),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: ZoomWidget(
                              isZoomAble: false,
                              child: CachedNetImage(
                                  imageUrl: FileUploadRepo()
                                          .savedPictureUrlInBackend ??
                                      '',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const CustomizeButton(),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 65,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const ProfileImageHolder(hasImage: true),
                                  24.heightBox,
                                  Text(userModel.userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: ElColors.whiteColor,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  4.heightBox,
                                  Text(userModel.secondName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: ElColors.whiteColor,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  37.heightBox,
                  CommonActionButton(
                      buttonName: ElStrings.save,
                      buttonColor: ElColors.buttonRedColor,
                      cornerRadius: 100,
                      onButtonTap: () {
                        Navigator.pop(context);
                      },
                      buttonTextStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ElColors.whiteColor,
                          fontSize: 20)),
                  35.heightBox
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

///widget to open pan and zoom screen.
class CustomizeButton extends StatelessWidget {
  const CustomizeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 14,
        top: 14,
        child: GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            var zoomProvider =
                Provider.of<ZoomProvider>(context, listen: false);
            var fileProvider =
                Provider.of<FileUploadProvider>(context, listen: false);
            Navigator.push(context, getCustomPageRoute(CustomiseCardPanZoom()))
                .then((value) {
              ///removing selected image file from cache.
              fileProvider.setSelectedFile(null);

              ///updating selected zoom/pan level
              zoomProvider.updateZoomLevel();
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: ElColors.whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    size: 15,
                    color: ElColors.buttonRedColor,
                  ),
                  4.widthBox,
                  const Text(ElStrings.customizeText,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ElColors.buttonRedColor)),
                ],
              )),
        ));
  }
}
