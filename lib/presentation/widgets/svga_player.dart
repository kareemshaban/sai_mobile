import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svgaplayer3/flutter_svgaplayer3.dart';
import 'package:new_sai/app/extensions.dart';

class SvgaPlayerWidget extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  const SvgaPlayerWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  State<SvgaPlayerWidget> createState() => _SvgaPlayerWidgetState();
}

class _SvgaPlayerWidgetState extends State<SvgaPlayerWidget>
    with SingleTickerProviderStateMixin {
  late SVGAAnimationController svgaAnimationController;

  @override
  void initState() {
    initSvgaController();
    super.initState();
  }

  initSvgaController() async {
    svgaAnimationController = SVGAAnimationController(vsync: this);
    final cache = await DefaultCacheManager().getFileFromCache(widget.url);
    if (cache == null) {
      final file = await DefaultCacheManager().downloadFile(widget.url);
      final cacheFile = await DefaultCacheManager()
          .putFile(file.file.path, await file.file.readAsBytes());
      svgaAnimationController.videoItem = await SVGAParser.shared
          .decodeFromBuffer(await cacheFile.readAsBytes());
    } else {
      svgaAnimationController.videoItem = await SVGAParser.shared
          .decodeFromBuffer(await cache.file.readAsBytes());
    }

    svgaAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SVGAImage(
        svgaAnimationController,
        fit: widget.fit,
      ),
    );
  }

  @override
  void dispose() {
    svgaAnimationController.dispose();
    super.dispose();
  }
}

class AssetsSvgaPlayer extends StatefulWidget {
  final String url;
  const AssetsSvgaPlayer({super.key, required this.url});

  @override
  State<AssetsSvgaPlayer> createState() => _AssetsSvgaPlayerState();
}

class _AssetsSvgaPlayerState extends State<AssetsSvgaPlayer>
    with SingleTickerProviderStateMixin {
  late SVGAAnimationController svgaAnimationController;

  @override
  void initState() {
    initSvgaController();
    super.initState();
  }

  @override
  void dispose() {
    svgaAnimationController.dispose();
    super.dispose();
  }

  initSvgaController() async {
    svgaAnimationController = SVGAAnimationController(vsync: this);
    svgaAnimationController.videoItem =
        await SVGAParser.shared.decodeFromAssets(widget.url);

    svgaAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.w(context),
      height: 1.h(context),
      child: SVGAImage(
        svgaAnimationController,
        fit: BoxFit.contain,
      ),
    );
  }
}
