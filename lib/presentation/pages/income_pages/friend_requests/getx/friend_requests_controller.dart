import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/domain/use_case/chat_use_case/accept_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/get_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/remove_friend_request_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class FriendRequestsController extends GetxController {
  final scrollController = ScrollController();
  final refreshController = RefreshController();
  final GetFriendRequestUseCase _friendRequestUseCase =
      instance<GetFriendRequestUseCase>();
  final AcceptFriendRequestUseCase _acceptFriendRequestUseCase =
      instance<AcceptFriendRequestUseCase>();
  final RemoveFriendRequestUseCase _removeFriendRequestUseCase =
      instance<RemoveFriendRequestUseCase>();
  int page = 1;

  final RxBool _loadingRequest = false.obs;
  final RxBool _loadingRequestPagination = false.obs;
  final RxList<FriendRequestEntity> _requests = <FriendRequestEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;

  bool get loadingRequest => _loadingRequest.value;
  bool get loadingRequestPagination => _loadingRequestPagination.value;
  List<FriendRequestEntity> get requests => _requests;
  PaginationEntity get pagination => _pagination.value;

  set loadingRequest(value) => _loadingRequest.value = value;
  set loadingRequestPagination(value) =>
      _loadingRequestPagination.value = value;
  set requests(List<FriendRequestEntity> value) => _requests.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;

  getFriendRequest({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingRequestPagination = true;
    } else {
      loadingRequest = true;
      requests.clear();
      page = 1;
    }
    (await _friendRequestUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        requests.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    loadingRequest = false;
    loadingRequestPagination = false;
  }

  acceptFriendRequest(int params) async {
    showAppLoadingDialog();
    (await _acceptFriendRequestUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        Get.back();
        await getFriendRequest();
      },
    );
  }

  removeFriendRequest(int params) async {
    showAppLoadingDialog();
    (await _removeFriendRequestUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
        refreshController.loadFailed();
      },
      (r) async {
        Get.back();
        await getFriendRequest();
        refreshController.loadComplete();
      },
    );
  }

  @override
  void onInit() async {
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingRequestPagination) {
          await getFriendRequest(isPaginate: true);
        }
      }
    });
    await getFriendRequest();
    super.onInit();
  }
}
