import 'package:cached_network_image/cached_network_image.dart';
import 'package:el_red/business/utils/el_colors.dart';
import 'package:el_red/business/utils/el_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///common button for all the screens.
class CommonActionButton extends StatelessWidget {
  final String buttonName;
  final Color? buttonColor, borderColor;
  final double? cornerRadius, borderWidth;
  final Function? onButtonTap;
  final TextStyle buttonTextStyle;

  const CommonActionButton(
      {super.key,
      this.borderColor,
      this.buttonColor,
      required this.buttonName,
      required this.buttonTextStyle,
      this.cornerRadius,
      this.borderWidth,
      this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onButtonTap != null) {
          onButtonTap!();
        }
      },
      onDoubleTap: () {},
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 14, bottom: 10),
        decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(
              width: borderWidth ?? 0,
              color: borderColor ?? ElColors.transparentColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 0))),
        child: Text(
          buttonName,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}

/// common app bar for the entire app.
class CommonAppBar extends StatelessWidget {
  final String title;
  final Widget? leadingIcon, trailingIcon;
  final Function? onLeadingIconTap, onTrailingIconTap;

  const CommonAppBar(
      {super.key,
      required this.title,
      this.leadingIcon,
      this.onLeadingIconTap,
      this.onTrailingIconTap,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ElColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          leadingIcon != null
              ? Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: leadingIcon!,
                    onPressed: () {
                      if (onLeadingIconTap != null) {
                        onLeadingIconTap!();
                      }
                    },
                  ),
                )
              : const SizedBox(width: 24, height: 40),
          Expanded(
            child: Text(title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ElColors.blackColor)),
          ),
          if (trailingIcon != null)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: trailingIcon!,
                onPressed: () {
                  if (trailingIcon != null) {
                    onTrailingIconTap!();
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}

/// common svg image holder
class SvgImageHolder extends StatelessWidget {
  final String image;
  final BoxFit? boxFit;
  final double? height, width;

  const SvgImageHolder(
      {super.key, required this.image, this.boxFit, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: boxFit ?? BoxFit.contain,
      height: height,
      width: width,
    );
  }
}

///common error widget for the application,retry option is optional.
class CommonErrorWidget extends StatelessWidget {
  final bool? hasRetryOption;
  final Function? onRetryTap;

  const CommonErrorWidget({super.key, this.hasRetryOption, this.onRetryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: ElColors.buttonRedColor, size: 30),
          if (hasRetryOption != null && hasRetryOption!)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextButton(
                  onPressed: () {
                    if (onRetryTap != null) {
                      onRetryTap!();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => ElColors.lightBlueColor)),
                  child: const Text(
                    ElStrings.retryText,
                    style: TextStyle(
                        color: ElColors.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
            )
        ],
      ),
    );
  }
}

///common progressbar for application.
class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, this.progressInfo});

  final String? progressInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(color: ElColors.buttonRedColor),
        if (progressInfo != null)
          Material(
            color: ElColors.transparentColor,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              color: ElColors.transparentColor,
              child: Text(
                "${progressInfo!} %",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ElColors.blackColor),
              ),
            ),
          )
      ],
    );
  }
}

///network image caching.
class CachedNetImage extends StatelessWidget {
  const CachedNetImage({super.key, required this.imageUrl, required this.fit});

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => const ProgressBar(),
      errorWidget: (context, url, error) => const CommonErrorWidget(),
    );
  }
}
