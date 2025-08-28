import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCircle;
  final double? radius;
  final Widget? errorWidget;
  final Color? imageColor;
  final bool withCache;

  const AppImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.isCircle = false,
    this.radius,
    this.errorWidget,
    this.imageColor,
    this.withCache = true,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: withCache ? image : getNoCacheUrl(),
      width: width,
      height: height,
      fit: fit,
      errorListener: (e) {},
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              colorFilter: imageColor != null
                  ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
                  : null,
              fit: fit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              ),
              child: const Center(
                child: Icon(Icons.info_outline),
              ),
            );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Skeletonizer(
          enabled: true,
          effect: const ShimmerEffect(),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(url),
                fit: fit,
              ),
            ),
          ),
        );
      },
    );
  }

  String getNoCacheUrl() {
    return "$image?timestamp=${DateTime.now().millisecondsSinceEpoch}";
  }
}
