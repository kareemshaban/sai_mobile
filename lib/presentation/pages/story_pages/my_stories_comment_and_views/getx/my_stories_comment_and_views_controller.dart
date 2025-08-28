import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_comment_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_views_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class MyStoriesCommentAndViewsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final commentScrollController = ScrollController();
  final viewsScrollController = ScrollController();
  int commentPage = 1;
  int viewsPage = 1;
  late StoryEntity story;
  final mediaController = FlutterCarouselController();

  final GetStoryCommentUseCase _commentUseCase =
      instance<GetStoryCommentUseCase>();
  final GetStoryViewsUseCase _getStoryViewsUseCase =
      instance<GetStoryViewsUseCase>();

  final RxInt _storyCurrentIndex = 0.obs;
  final RxBool _loadingComment = false.obs;
  final RxBool _loadingCommentPagination = false.obs;
  final RxList<ReelsCommentEntity> _comments = <ReelsCommentEntity>[].obs;
  final Rx<PaginationEntity> _commentPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingViews = false.obs;
  final RxBool _loadingViewsPagination = false.obs;
  final RxList<ReelsCommentEntity> _views = <ReelsCommentEntity>[].obs;
  final Rx<PaginationEntity> _viewsPagination =
      PaginationModel().toDomain().obs;

  int get storyCurrentIndex => _storyCurrentIndex.value;
  bool get loadingComment => _loadingComment.value;
  bool get loadingCommentPagination => _loadingCommentPagination.value;
  List<ReelsCommentEntity> get comments => _comments;
  PaginationEntity get commentPagination => _commentPagination.value;
  bool get loadingViews => _loadingViews.value;
  bool get loadingViewsPagination => _loadingViewsPagination.value;
  List<ReelsCommentEntity> get views => _views;
  PaginationEntity get viewsPagination => _viewsPagination.value;

  set storyCurrentIndex(value) => _storyCurrentIndex.value = value;
  set loadingComment(value) => _loadingComment.value = value;
  set loadingCommentPagination(value) =>
      _loadingCommentPagination.value = value;
  set comments(List<ReelsCommentEntity> value) => _comments.value = value;
  set commentPagination(PaginationEntity value) =>
      _commentPagination.value = value;
  set loadingViews(value) => _loadingViews.value = value;
  set loadingViewsPagination(value) => _loadingViewsPagination.value = value;
  set views(List<ReelsCommentEntity> value) => _views.value = value;
  set viewsPagination(PaginationEntity value) => _viewsPagination.value = value;

  getStoryComment({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingCommentPagination = true;
    } else {
      loadingComment = true;
      commentPage = 1;
      comments.clear();
    }
    (await _commentUseCase.execute({
      "id": story.media[storyCurrentIndex].id,
      "page": commentPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        comments.addAll(r.data);
        commentPagination = r.pagination;
        commentPage++;
      },
    );
    loadingComment = false;
    loadingCommentPagination = false;
  }

  getStoryViews({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingViewsPagination = true;
    } else {
      loadingViews = true;
      viewsPage = 1;
      views.clear();
    }
    (await _getStoryViewsUseCase.execute({
      "id": story.media[storyCurrentIndex].id,
      "page": viewsPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        views.addAll(r.data);
        viewsPagination = r.pagination;
        viewsPage++;
      },
    );
    loadingViews = false;
    loadingViewsPagination = false;
  }

  onChangedStoryIndex(value) {
    storyCurrentIndex = value;
    getStoryComment();
    getStoryViews();
  }

  @override
  void onInit() async {
    story = Get.arguments;
    tabController = TabController(length: 2, vsync: this);
    commentScrollController.addListener(() async {
      if (commentScrollController.offset ==
          commentScrollController.position.maxScrollExtent) {
        if (commentPagination.nextPageUrl.isNotEmpty &&
            !loadingCommentPagination) {
          await getStoryComment(isPaginate: true);
        }
      }
    });
    viewsScrollController.addListener(() async {
      if (viewsScrollController.offset ==
          viewsScrollController.position.maxScrollExtent) {
        if (viewsPagination.nextPageUrl.isNotEmpty && !loadingViewsPagination) {
          await getStoryViews(isPaginate: true);
        }
      }
    });
    await getStoryViews();
    await getStoryComment();
    super.onInit();
  }
}
