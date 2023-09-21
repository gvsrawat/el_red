import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/providers/zoom_provider.dart';
import 'package:el_red/business/repositories/file_repo.dart';
import 'package:el_red/business/utils/custom_page_transition.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_const_sizes.dart';
import 'package:el_red/business/utils/el_image_paths.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/business/utils/extennsions.dart';
import 'package:el_red/models/user_model.dart';
import 'package:el_red/presentation/image_oper_views/customise_your_card.dart';
import 'package:el_red/presentation/image_oper_views/profile_avatar_widget.dart';
import 'package:el_red/presentation/image_oper_views/zoomable_widget.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///stateful class for fetching & displaying of banner image.
class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late FileUploadProvider _fileUploadProvider;

  @override
  void initState() {
    ///setting is bannerUploading to true, so that Ui can show progress indicator.
    Provider.of<FileUploadProvider>(context, listen: false)
        .setBannerImageLoadingFlag(true);

    ///once build method runs successfully , this callback will be executed and bannerImage will be fetched.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getDetails(shouldUpdateUi: true);
    });
    super.initState();
  }

  ///to get banner image details helper function
  void _getDetails({bool shouldUpdateUi = false}) {
    Provider.of<FileUploadProvider>(context, listen: false)
        .getBannerImage(shouldUpdateUi: shouldUpdateUi);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FileUploadProvider>(builder: (context, provider, child) {
      _fileUploadProvider = provider;
      return WillPopScope(
        onWillPop: () async {
          if (_fileUploadProvider.fetchingBannerImage) {
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
                  title: ElStrings.artist,
                  onLeadingIconTap: () {
                    if (_fileUploadProvider.fetchingBannerImage) {
                      return;
                    }
                    Navigator.pop(context);
                  },
                  leadingIcon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (_fileUploadProvider.fetchingBannerImage) {
                      return const ProgressBar();
                    } else if (FileUploadRepo().savedPictureUrlInBackend ==
                            null ||
                        FileUploadRepo()
                            .savedPictureUrlInBackend!
                            .trim()
                            .isEmpty) {
                      return CommonErrorWidget(
                        hasRetryOption: true,
                        onRetryTap: () => _getDetails(shouldUpdateUi: true),
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                                      isZoomAble: false,
                                      child: CachedNetImage(
                                        fit: BoxFit.cover,
                                        imageUrl: FileUploadRepo()
                                                .savedPictureUrlInBackend ??
                                            '',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 65,
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
                                                    color: ElColors.whiteColor,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              4.heightBox,
                                              Text(userModel.secondName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: ElColors.whiteColor,
                                                    fontWeight: FontWeight.w600,
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
                                                      color:
                                                          ElColors.whiteColor)),
                                              5.heightBox,
                                              Text(userModel.location,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ElColors.whiteColor))
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                Positioned(
                                    bottom: 12,
                                    left: 14,
                                    child: RichText(
                                        text: const TextSpan(children: [
                                      TextSpan(
                                          text: ElStrings.elText,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: ElColors.whiteColor)),
                                      TextSpan(
                                          text: ElStrings.redText,
                                          style: TextStyle(
                                              fontSize: 22,
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w600,
                                              color: ElColors.whiteColor))
                                    ]))),
                                const Positioned(
                                    bottom: 12,
                                    right: 14,
                                    child: SvgImageHolder(
                                        image: ElImages.profileTextImageSvg))
                              ],
                            ),
                          ),
                        ),
                        11.heightBox,
                        Container(
                          margin: ElSizes.getCommonScreenPadding(),
                          child: CommonActionButton(
                              buttonName: ElStrings.edit,
                              buttonColor: ElColors.whiteColor,
                              cornerRadius: 100,
                              borderWidth: 1,
                              onButtonTap: () {
                                var zoomProvider = Provider.of<ZoomProvider>(
                                    context,
                                    listen: false);
                                Navigator.push(
                                        context,
                                        getCustomPageRoute(
                                            const CustomiseYourCardScreen()))
                                    .then((value) {
                                  zoomProvider.updateZoomLevel();
                                });
                              },
                              borderColor: ElColors.buttonRedColor,
                              buttonTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ElColors.buttonRedColor,
                                  fontSize: 20)),
                        ),
                        35.heightBox,
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
