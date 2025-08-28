import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late bool isStory;
  final imageScrollController = ScrollController();
  final videoScrollController = ScrollController();
  final allScrollController = ScrollController();
  final RxList<AssetEntity> _imagePaths = <AssetEntity>[].obs;
  final RxList<AssetEntity> _videoPaths = <AssetEntity>[].obs;
  final RxList<AssetEntity> _allPaths = <AssetEntity>[].obs;
  final RxList<SelectedPathsModel> _selectedFilePaths =
      <SelectedPathsModel>[].obs;
  final RxBool _loading = false.obs;
  int imagePage = 0;
  int videoPage = 0;
  int allPage = 0;

  List<AssetEntity> get imagePaths => _imagePaths;
  List<AssetEntity> get videoPaths => _videoPaths;
  List<AssetEntity> get allPaths => _allPaths;
  List<SelectedPathsModel> get selectedFilePaths => _selectedFilePaths;
  bool get loading => _loading.value;

  set imagePaths(List<AssetEntity> value) => _imagePaths.value = value;
  set videoPaths(List<AssetEntity> value) => _videoPaths.value = value;
  set allPaths(List<AssetEntity> value) => _allPaths.value = value;
  set selectedFilePaths(List<SelectedPathsModel> value) =>
      _selectedFilePaths.value = value;
  set loading(value) => _loading.value = value;

  getImageAssetPath() async {
    final album = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );
    if (album.isNotEmpty) {
      imagePaths
          .addAll(await album[0].getAssetListPaged(page: imagePage, size: 100));
    }
  }

  getVideoAssetPath() async {
    final album = await PhotoManager.getAssetPathList(
      type: RequestType.video,
      onlyAll: true,
    );
    if (album.isNotEmpty) {
      videoPaths
          .addAll(await album[0].getAssetListPaged(page: videoPage, size: 100));
    }
  }

  getAllAssetPath() async {
    final album = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: true,
    );
    if (album.isNotEmpty) {
      allPaths
          .addAll(await album[0].getAssetListPaged(page: allPage, size: 100));
    }
  }

  onTapOnItem(SelectedPathsModel? item) {
    if (item != null) {
      if (selectedFilePaths
          .where((element) => element.path == item.path)
          .isNotEmpty) {
        selectedFilePaths.removeWhere((element) => element.path == item.path);
      } else {
        selectedFilePaths.add(item);
      }
    }
    // _videoPaths.refresh();
    // _imagePaths.refresh();
    // _allPaths.refresh();
  }

  @override
  void onInit() async {
    isStory = Get.arguments['isStory'] ?? false;
    tabController = TabController(length: 3, vsync: this, initialIndex: 2);
    loading = true;
    final PermissionState photoPermission =
        await PhotoManager.requestPermissionExtend();
    if (!photoPermission.hasAccess) {
      PhotoManager.openSetting();
    }
    await getImageAssetPath();
    await getVideoAssetPath();
    await getAllAssetPath();
    loading = false;
    imageScrollController.addListener(() async {
      if (imageScrollController.offset ==
          imageScrollController.position.maxScrollExtent) {
        imagePage++;
        await getImageAssetPath();
      }
    });
    videoScrollController.addListener(() async {
      if (videoScrollController.offset ==
          videoScrollController.position.maxScrollExtent) {
        videoPage++;
        await getVideoAssetPath();
      }
    });
    allScrollController.addListener(() async {
      if (allScrollController.offset ==
          allScrollController.position.maxScrollExtent) {
        allPage++;
        await getAllAssetPath();
      }
    });
    super.onInit();
  }
}

class SelectedPathsModel {
  final String path;
  final AssetType type;
  String thumb;

  SelectedPathsModel({
    required this.path,
    required this.type,
    this.thumb = '',
  });
}
