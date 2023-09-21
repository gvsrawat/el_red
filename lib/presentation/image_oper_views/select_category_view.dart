import 'package:el_red/business/providers/file_provider.dart';
import 'package:el_red/business/utils/custom_page_transition.dart';
import 'package:el_red/business/utils/el_const_sizes.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_image_paths.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:el_red/presentation/image_oper_views/upload_picture_view.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///initial screen to choose image.
class SelectCategoryScreen extends StatelessWidget {
  SelectCategoryScreen({super.key, this.fileUploadProvider});

  FileUploadProvider? fileUploadProvider;

  @override
  Widget build(BuildContext context) {
    fileUploadProvider =
        Provider.of<FileUploadProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ElColors.whiteColor,
      body: SafeArea(
          child: Column(
        children: [
          const CommonAppBar(title: ElStrings.changeDesign),
          Container(
            margin: ElSizes.getCommonScreenPadding(),
            child: GestureDetector(
              onTap: () {
                fileUploadProvider?.selectImageOptions(context,
                    onSelectionDone: () => Navigator.push(
                        context, getCustomPageRoute(UploadPictureScreen())));
              },
              onDoubleTap: () {},
              child: const SizedBox(
                  height: 65,
                  child: SvgImageHolder(
                      image: ElImages.selectCategorySvg, boxFit: BoxFit.fill)),
            ),
          ),
        ],
      )),
    );
  }
}
