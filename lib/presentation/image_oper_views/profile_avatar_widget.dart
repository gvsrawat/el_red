import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_image_paths.dart';
import 'package:el_red/presentation/shareable_widgets.dart';
import 'package:flutter/material.dart';

///this widget provides the reusable profile avatar.
class ProfileImageHolder extends StatelessWidget {
  const ProfileImageHolder({super.key, required this.hasImage});

  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return hasImage
        ? const SvgImageHolder(image: ElImages.profilePicPlaceholderSvg)
        : Stack(
            children: [
              Container(
                width: 124,
                height: 124,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ElColors.whiteColor),
              ),
              Positioned(
                  left: 6,
                  right: 6,
                  top: 6,
                  bottom: 6,
                  child: Container(
                      width: 114.8217544555664,
                      height: 114.97297668457031,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ElColors.circleAvtarGrey)))
            ],
          );
  }
}
