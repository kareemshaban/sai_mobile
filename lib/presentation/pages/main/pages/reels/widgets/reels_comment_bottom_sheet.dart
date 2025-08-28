import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_reels_comment_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/reels_add_comment_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/getx/users_and_saved_reels_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ReelsCommentBottomSheet extends StatefulWidget {
  final bool allowComment;
  final int reelsID;
  const ReelsCommentBottomSheet({
    this.allowComment = true,
    required this.reelsID,
    super.key,
  });

  @override
  State<ReelsCommentBottomSheet> createState() =>
      _ReelsCommentBottomSheetState();
}

class _ReelsCommentBottomSheetState extends State<ReelsCommentBottomSheet> {
  final reelsController = Get.find<ReelsController>();
  final commentScrollController = ScrollController();
  final addCommentController = TextEditingController();
  int commentPage = 1;

  final RxBool _loadingGetComment = false.obs;
  final RxBool _loadingGetCommentPagination = false.obs;
  final RxList<ReelsCommentEntity> _comments = <ReelsCommentEntity>[].obs;
  final Rx<PaginationEntity> _commentPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingAddComment = false.obs;

  bool get loadingGetComment => _loadingGetComment.value;
  bool get loadingGetCommentPagination => _loadingGetCommentPagination.value;
  List<ReelsCommentEntity> get comments => _comments;
  PaginationEntity get commentPagination => _commentPagination.value;
  bool get loadingAddComment => _loadingAddComment.value;

  set loadingGetComment(value) => _loadingGetComment.value = value;
  set loadingGetCommentPagination(value) =>
      _loadingGetCommentPagination.value = value;
  set comments(List<ReelsCommentEntity> value) => _comments.value = value;
  set commentPagination(PaginationEntity value) =>
      _commentPagination.value = value;
  set loadingAddComment(value) => _loadingAddComment.value = value;

  final GetReelsCommentUseCase _commentUseCase =
      instance<GetReelsCommentUseCase>();
  final ReelsAddCommentUseCase _addCommentUseCase =
      instance<ReelsAddCommentUseCase>();

  getComment({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingGetCommentPagination = true;
    } else {
      loadingGetComment = true;
      commentPage = 1;
      comments.clear();
    }
    (await _commentUseCase.execute({
      "id": widget.reelsID,
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
    loadingGetCommentPagination = false;
    loadingGetComment = false;
  }

  addComment() async {
    if (addCommentController.text.isEmpty) {
      return;
    }
    if (loadingAddComment) {
      return;
    }
    loadingAddComment = true;
    final params = ReelsCommentParams(
      id: widget.reelsID,
      comment: addCommentController.text,
    );
    (await _addCommentUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        comments.add(r);
        addCommentController.clear();
        if (Get.currentRoute == AppRoutes.mainRoute) {
          reelsController.updateReelComment(widget.reelsID);
        } else {
          final userReelsController = Get.find<UsersAndSavedReelsController>();
          userReelsController.updateReelComment(widget.reelsID);
        }
      },
    );
    loadingAddComment = false;
  }

  @override
  void initState() {
    commentScrollController.addListener(() async {
      if (commentScrollController.offset ==
          commentScrollController.position.maxScrollExtent) {
        if (commentPagination.nextPageUrl.isNotEmpty &&
            !loadingGetCommentPagination) {
          await getComment(isPaginate: true);
        }
      }
    });
    getComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 1.w(context),
        constraints: BoxConstraints(
          maxHeight: .7.h(context),
        ),
        decoration: const BoxDecoration(
          color: ColorManager.scaffoldBackground,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: loadingGetComment
            ? const Center(child: AppLoader())
            : Column(
                children: [
                  Text(
                    AppStrings.comments,
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
                  20.verticalSpace(),
                  const Divider(height: 0),
                  20.verticalSpace(),
                  Expanded(
                    child: comments.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.noDataFound,
                              style: Get.textTheme.titleMedium!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            ),
                          )
                        : ListView.separated(
                            controller: commentScrollController,
                            padding: const EdgeInsets.only(bottom: 20),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.userProfileRoute,
                                    arguments: {
                                      'id': comments[index].user.id,
                                      'isFromChat': false,
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Image.network(
                                        comments[index].user.logo,
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const AppImage(
                                          image: Constants.userErrorWidget,
                                          width: 45,
                                          height: 45,
                                          isCircle: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    6.horizontalSpace(),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comments[index].user.name,
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                              fontSize: AppSize.s15(context),
                                            ),
                                          ),
                                          Text(
                                            comments[index].comment,
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                              fontSize: AppSize.s15(context),
                                            ),
                                          ),
                                          Text(
                                            comments[index].createdAt,
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                              fontSize: AppSize.s12(context),
                                              color: ColorManager.black
                                                  .withOpacity(.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                15.verticalSpace(),
                            itemCount: comments.length,
                          ),
                  ),
                  if (widget.allowComment)
                    Row(
                      children: [
                        Expanded(
                          child: AppFormFiled(
                            hint: AppStrings.addComment,
                            controller: addCommentController,
                            borderColor: ColorManager.black.withOpacity(.2),
                            borderRadius: 30,
                          ),
                        ),
                        10.horizontalSpace(),
                        RotatedBox(
                          quarterTurns: context.locale == arabicLocale ? 2 : 0,
                          child: loadingAddComment
                              ? const Center(child: AppLoader())
                              : InkWell(
                                  onTap: addComment,
                                  child: const AppIcon(
                                    icon: IconsAssets.sendButton,
                                    color: ColorManager.primary,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                        right: 16,
                      ),
                      child: Text(
                        AppStrings.commentsOnThisReelHaveBeenDisabled,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
