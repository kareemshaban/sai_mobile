import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_users_type_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/get_my_conversations_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class IncomeController extends GetxController {

  final RxBool _loadingUsers = false.obs;
  final RxBool _loadingUsersPagination = false.obs;
  final RxList<UserEntity> _users = <UserEntity>[].obs;
  final Rx<PaginationEntity> _usersPagination =
      PaginationModel().toDomain().obs;
      bool get loadingUsers => _loadingUsers.value;
  set usersPagination(PaginationEntity value) => _usersPagination.value = value;
  set users(List<UserEntity> value) => _users.value = value;
  set loadingUsersPagination(value) => _loadingUsersPagination.value = value;
  List<UserEntity> get users => _users;
  
    final GetUsersTypeUseCase _getUsersTypeUseCase =
      instance<GetUsersTypeUseCase>();
  final scrollController = ScrollController();
  final appController = Get.find<AppController>();

  set loadingUsers(value) => _loadingUsers.value = value;
  final refreshController = RefreshController(
    initialLoadStatus: LoadStatus.loading,
  );
  final GetMyConversationsUseCase _conversationsUseCase =
      instance<GetMyConversationsUseCase>();
  int page = 1;

  final RxBool _loadingConv = false.obs;
  final RxBool _loadingConvPagination = false.obs;
  final RxList<MyConversationsEntity> _myConversations =
      <MyConversationsEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;

  PaginationEntity get pagination => _pagination.value;

  bool get loadingConv => _loadingConv.value;
  bool get loadingConvPagination => _loadingConvPagination.value;
  List<MyConversationsEntity> get myConversations => _myConversations;
  set loadingConv(value) => _loadingConv.value = value;
  set loadingConvPagination(value) => _loadingConvPagination.value = value;
  int userNumbersPage = 1;
  set myConversations(List<MyConversationsEntity> value) =>
      _myConversations.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;

  getUserFriend({
    bool isPaginate = false,
  }) async {
    if (isPaginate) {
      loadingUsersPagination = true;
    } else {
      loadingUsers = true;
      userNumbersPage = 1;
      users.clear();
    }

    final response = await _getUsersTypeUseCase.execute({
      'page': userNumbersPage,
      'type': "following",
    });

    response.fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userNumbersPage++;
       for(int i =0 ; i<r.list.data.length;i++){
        if(r.list.data[i].isFriend==true || r.list.data[i].isFollow==true){
        users.add(r.list.data[i]);
        }
       }
        usersPagination = r.list.pagination;
      },
    );
    loadingUsersPagination = false;
    loadingUsers = false;
  }

  getMyConversation({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingConvPagination = true;
    } else {
      loadingConv = true;
      myConversations.clear();
      page = 1;
    }
    (await _conversationsUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
        refreshController.loadFailed();
      },
      (r) {
        myConversations.addAll(r.data);
        pagination = r.pagination;
        page++;
        refreshController.loadComplete();
      },
    );
    loadingConv = false;
    loadingConvPagination = false;
  }

  @override
  void onInit() async {
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingConvPagination) {
          await getMyConversation(isPaginate: true);
        }
      }
    });
    if (!isGuest()) {
      await getUserFriend(isPaginate: false);
      await getMyConversation();
    }
    super.onInit();
  }
}
