import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svgaplayer3/parser.dart';
import 'package:flutter_svgaplayer3/player.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_permission.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/room_model/gift_model.dart';
import 'package:new_sai/data/model/room_model/joined_room_model.dart';
import 'package:new_sai/data/model/room_model/room_user_model.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/data/params/room_params/fire_user_params.dart';
import 'package:new_sai/data/params/room_params/generate_zego_token_params.dart';
import 'package:new_sai/data/params/room_params/lock_room_params.dart';
import 'package:new_sai/data/params/room_params/lock_unlock_mic_params.dart';
import 'package:new_sai/data/params/room_params/room_report_params.dart';
import 'package:new_sai/data/params/room_params/room_user_params.dart';
import 'package:new_sai/data/params/room_params/send_gift_params.dart';
import 'package:new_sai/data/params/room_params/send_message_params.dart';
import 'package:new_sai/data/params/room_params/update_role_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/domain/entity/room_entity/joined_room_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_user_entity.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_app_search_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/cancel_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/cancel_membership_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/fire_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/generate_zego_token_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_gift_list_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_mempers_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_room_user_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_users_in_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/join_as_member_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/join_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/leave_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/lock_mic_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/lock_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_gift_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_message_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/send_room_report_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/unlock_mic_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/unlock_room_use_case.dart';
import 'package:new_sai/domain/use_case/room_use_case/update_user_role_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/lock_seat_local_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/message_local_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/message_widget_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_send_gift_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_update_settings_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/pages/music_playlist_view.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/accept_role_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/gifts_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/user_profile_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/error_connection_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/general_notification_message.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/gift_message_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/gift_notification.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/message_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/new_user_entry_notification.dart';
import 'package:new_sai/presentation/pages/room_pages/room/zego_handler/live_audio_room_manager.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../app/app_pref.dart';
import '../../../../../data/model/game_model/game_model.dart';

class RoomController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  final _channel = const MethodChannel('audio_control_channel');
  UserEntity user = Get.find<AppController>().user;
  final isLoadingGams = false.obs;
  final isPlayingGame = false.obs;
  final appController = Get.find<AppController>();
  final cashWithdrawalController = Get.find<CashWithdrawalController>();
  final RxBool isInSettingsMode = false.obs;
  late AnimationController animationController;
  RxList<Map<String, dynamic>> giftUrls = <Map<String, dynamic>>[].obs;
  RxBool showLottie = false.obs;
  final lockRoomFormKey = GlobalKey<FormState>();
  final reportFormKey = GlobalKey<FormState>();
  final roomMemperPageController = PageController();
  final roomMemperSearchController = TextEditingController();
  final messageController = DetectableTextEditingController(
    regExp: atSignRegExp,
    detectedStyle: Get.textTheme.displayLarge!.copyWith(
      fontSize: 15,
    ),
  );
  Rx<GameResponse?> gameResponse = Rx<GameResponse?>(null);

  RxList<GameItem> gameItems = <GameItem>[].obs;
  Rx<Game> currentGame =
      Game(id: 0, name: "", icon: "", url: "", active: 0).obs;
  final lockRoomController = TextEditingController();
  final reportRoomController = TextEditingController();
  final GetAppSearchUseCase _appSearchUseCase = instance<GetAppSearchUseCase>();
  final JoinRoomUseCase _joinRoomUseCase = instance<JoinRoomUseCase>();
  final GenerateZegoTokenUseCase _generateZegoTokenUseCase =
      instance<GenerateZegoTokenUseCase>();
  final LeaveRoomUseCase _leaveRoomUseCase = instance<LeaveRoomUseCase>();
  final GetRoomUserUseCase _getRoomUserUseCase = instance<GetRoomUserUseCase>();
  final GetGiftListUseCase _getGiftListUseCase = instance<GetGiftListUseCase>();
  final SendRoomMessageUseCase _messageUseCase =
      instance<SendRoomMessageUseCase>();
  final LockMicUseCase _lockMicUseCase = instance<LockMicUseCase>();
  final UnlockMicUseCase _unlockMicUseCase = instance<UnlockMicUseCase>();
  final LockRoomUseCase _lockRoomUseCase = instance<LockRoomUseCase>();
  final UnlockRoomUseCase _unlockRoomUseCase = instance<UnlockRoomUseCase>();
  final FireUserUseCase _fireUserUseCase = instance<FireUserUseCase>();
  final UpdateUserRoleUseCase updateUserRoleUseCase =
      instance<UpdateUserRoleUseCase>();
  final GetRoomMempersUseCase _getRoomMempersUseCase =
      instance<GetRoomMempersUseCase>();
  final CancelMembershipUseCase _cancelMembershipUseCase =
      instance<CancelMembershipUseCase>();
  final JoinAsMemberUseCase _joinAsMemberUseCase =
      instance<JoinAsMemberUseCase>();
  final SendRoomReportUseCase _reportUseCase =
      instance<SendRoomReportUseCase>();
  final GetUsersInRoomUseCase _getUsersInRoomUseCase =
      instance<GetUsersInRoomUseCase>();
  final SendFriendRequestUseCase _friendRequestUseCase =
      instance<SendFriendRequestUseCase>();
  final CancelFriendRequestUseCase _cancelFriendRequestUseCase =
      instance<CancelFriendRequestUseCase>();
  final SendRoomGiftUseCase _sendRoomGiftUseCase =
      instance<SendRoomGiftUseCase>();
  late SVGAAnimationController svgController;
  RxList<String> giftQueue = <String>[].obs;
  var isVisible = false.obs;
  var isCompositionLoaded = false;
  List<StreamSubscription> subscriptions = [];
  final scrollController = ScrollController();
  final scrollController2 = ScrollController();
  final roomMempersScrollController = ScrollController();
  late FocusNode focusNode;
  String zegoToken = '';
  String roomId = '';
  final int appID = 1185437134;
  final String appSign =
      "b332860e1a5f68fdb29e164326f6e96183295ec2c815383bba716c509a529e71";
  ZegoMediaPlayer? mediaPlayer;
  List<int> giftCounterItems = [1, 7, 17, 77, 777];
  late Box<RoomSongModel> songBox;
  late AudioPlayer musicPlayer;
  int roomMempersPage = 1;
  bool isSvg = false;
  bool isNotSvg = false;
  final RxBool _enableScroll = false.obs;
  final RxBool _loadingJoinRoom = false.obs;
  final Rx<JoinedRoomEntity> newRoom = JoinedRoomModel().toDomain().obs;
  final RxMap<String, String> _micUsers = <String, String>{}.obs;
  final RxList<ZegoUser> _users = <ZegoUser>[].obs;
  final RxBool _micState = true.obs;
  final RxBool _isSpeaking = false.obs;
  final RxBool _isTakingSeat = false.obs;
  final RxBool _isMuteAll = false.obs;
  final RxBool _loadingGetProfile = false.obs;
  final RxBool _loadingGetGift = false.obs;
  final RxBool _displaySvgAnimatedGift = false.obs;
  final RxMap<String, double> _soundLevel = <String, double>{}.obs;
  final RxList<GiftEntity> _gifts = <GiftEntity>[].obs;
  final RxList<GiftCategoryEntity> _giftsCategories =
      <GiftCategoryEntity>[].obs;
  final RxList<Uint8List> _pendingGiftList = <Uint8List>[].obs;
  final Rx<GiftEntity> _selectedGift = GiftModel().toDomain().obs;
  final RxList<LockedSeatLocalModel> _lockedSeatList =
      <LockedSeatLocalModel>[].obs;
  final RxString _messageImage = ''.obs;
  final RxList<Widget> _messages = <Widget>[].obs;
  final RxList<Widget> _roomNotificationList = <Widget>[].obs;
  final RxBool _loadingLockRoom = false.obs;
  final RxBool _showMusicPlayer = false.obs;
  final RxBool _showMusicSound = false.obs;
  final RxList<RoomSongModel> _songs = <RoomSongModel>[].obs;
  final RxInt _currentSongIndex = 0.obs;
  final RxDouble _soundValue = 20.0.obs;
  final Rx<Duration> _songDuration = const Duration().obs;
  final RxBool _shouldCycle = false.obs;
  final RxBool _isPlayingMusic = false.obs;
  final RxDouble _songSliderValue = 0.0.obs;
  final RxInt _giftCount = 1.obs;
  final Rx<ZegoUser> _selectedUserGift =
      ZegoUser(AppStrings.all, AppStrings.all).obs;
  final Rx<PaginationEntity> _roomMempersPagination =
      PaginationModel().toDomain().obs;

  final RxList<UserEntity> _roomMempers = <UserEntity>[].obs;
  final RxBool _loadingRoomMempers = false.obs;
  final RxBool _loadingRoomMempersPaginate = false.obs;
  final RxList<String> _mutedListLocally = <String>[].obs;
  final RxList<String> _mutedList = <String>[].obs;
  final RxBool _kickOutPermanently = false.obs;
  final RxList<ZegoUser> _requestMicList = <ZegoUser>[].obs;
  final RxList<UserEntity> _apiUsers = <UserEntity>[].obs;
  final Rx<RoomUserEntity> _userProfile = RoomUserModel().toDomain().obs;
  final RxBool _loadingCancelFriend = false.obs;
  final RxBool _loadingSendFriend = false.obs;
  final RxBool _loadingCancelMempership = false.obs;
  final RxBool _loadingFireUser = false.obs;
  final RxBool _loadingJoinAsMemper = false.obs;
  final RxBool _loadingSendGift = false.obs;
  final RxBool _loadingSendMessage = false.obs;
  final RxBool _loadingReport = false.obs;
  final RxBool _loadingUpdateUserRole = false.obs;
  final RxBool _enableTag = false.obs;
  final RxBool _loadingSearch = false.obs;
  final RxList<UserEntity> _searchUsers = <UserEntity>[].obs;

  bool get enableScroll => _enableScroll.value;
  bool get loadingJoinRoom => _loadingJoinRoom.value;
  JoinedRoomEntity get room => newRoom.value;
  Map<String, String> get micUsers => _micUsers;
  List<ZegoUser> get users => _users;
  bool get micState => _micState.value;
  bool get isSpeaking => _isSpeaking.value;
  bool get isTakingSeat => _isTakingSeat.value;
  bool get isMuteAll => _isMuteAll.value;
  bool get loadingGetProfile => _loadingGetProfile.value;
  bool get loadingGetGift => _loadingGetGift.value;
  bool get displaySvgAnimatedGift => _displaySvgAnimatedGift.value;
  Map<String, double> get soundLevel => _soundLevel;
  List<GiftEntity> get gifts => _gifts;
  RxString jsonGift = ''.obs;
  List<GiftCategoryEntity> get giftsCategories => _giftsCategories;
  List<Uint8List> get pendingGiftList => _pendingGiftList;
  GiftEntity get selectedGift => _selectedGift.value;
  List<LockedSeatLocalModel> get lockedSeatList => _lockedSeatList;
  String get messageImage => _messageImage.value;
  List<Widget> get messages => _messages;
  List<Widget> get roomNotificationList => _roomNotificationList;
  bool get loadingLockRoom => _loadingLockRoom.value;
  bool get showMusicPlayer => _showMusicPlayer.value;
  bool get showMusicSound => _showMusicSound.value;
  List<RoomSongModel> get songs => _songs;
  int get currentSongIndex => _currentSongIndex.value;
  double get soundValue => _soundValue.value;
  Duration get songDuration => _songDuration.value;
  bool get shouldCycle => _shouldCycle.value;
  bool get isPlayingMusic => _isPlayingMusic.value;
  double get songSliderValue => _songSliderValue.value;
  int get giftCount => _giftCount.value;
  ZegoUser get selectedUserGift => _selectedUserGift.value;
  PaginationEntity get roomMempersPagination => _roomMempersPagination.value;
  List<UserEntity> get roomMempers => _roomMempers;
  bool get loadingRoomMempers => _loadingRoomMempers.value;
  bool get loadingRoomMempersPaginate => _loadingRoomMempersPaginate.value;
  List<String> get mutedListLocally => _mutedListLocally;
  List<String> get mutedList => _mutedList;
  bool get kickOutPermanently => _kickOutPermanently.value;
  List<ZegoUser> get requestMicList => _requestMicList;
  List<UserEntity> get apiUsers => _apiUsers;
  RoomUserEntity get userProfile => _userProfile.value;
  bool get loadingCancelFriend => _loadingCancelFriend.value;
  bool get loadingSendFriend => _loadingSendFriend.value;
  bool get loadingCancelMempership => _loadingCancelMempership.value;
  bool get loadingFireUser => _loadingFireUser.value;
  bool get loadingJoinAsMemper => _loadingJoinAsMemper.value;
  bool get loadingSendGift => _loadingSendGift.value;
  bool get loadingSendMessage => _loadingSendMessage.value;
  bool get loadingReport => _loadingReport.value;
  bool get loadingUpdateUserRole => _loadingUpdateUserRole.value;
  bool get enableTag => _enableTag.value;
  bool get loadingSearch => _loadingSearch.value;
  List<UserEntity> get searchUsers => _searchUsers;

  set enableScroll(value) {
    _enableScroll.value = value;
    if (value) {
      animateToLast();
    }
  }

  set loadingJoinRoom(value) => _loadingJoinRoom.value = value;
  set room(JoinedRoomEntity value) => newRoom.value = value;
  set micUsers(Map<String, String> value) => _micUsers.value = value;
  set users(List<ZegoUser> value) => _users.value = value;
  set micState(value) => _micState.value = value;
  set isSpeaking(value) => _isSpeaking.value = value;
  set isTakingSeat(value) => _isTakingSeat.value = value;
  set isMuteAll(value) => _isMuteAll.value = value;
  set loadingGetProfile(value) => _loadingGetProfile.value = value;
  set loadingGetGift(value) => _loadingGetGift.value = value;
  set displaySvgAnimatedGift(value) => _displaySvgAnimatedGift.value = value;
  set soundLevel(Map<String, double> value) => _soundLevel.value = value;
  set gifts(List<GiftEntity> value) => _gifts.value = value;
  set giftsCategories(List<GiftCategoryEntity> value) =>
      _giftsCategories.value = value;
  set pendingGiftList(List<Uint8List> value) => _pendingGiftList.value = value;
  set selectedGift(GiftEntity value) => _selectedGift.value = value;
  set lockedSeatList(List<LockedSeatLocalModel> value) =>
      _lockedSeatList.value = value;
  set messageImage(value) => _messageImage.value = value;
  set messages(List<Widget> value) => _messages.value = value;
  set roomNotificationList(List<Widget> value) =>
      _roomNotificationList.value = value;
  set loadingLockRoom(value) => _loadingLockRoom.value = value;
  set showMusicPlayer(value) => _showMusicPlayer.value = value;
  set showMusicSound(value) => _showMusicSound.value = value;
  set songs(List<RoomSongModel> value) => _songs.value = value;
  set currentSongIndex(value) => _currentSongIndex.value = value;
  set soundValue(value) => _soundValue.value = value;
  set songDuration(Duration value) => _songDuration.value = value;
  set shouldCycle(value) => _shouldCycle.value = value;
  set isPlayingMusic(value) => _isPlayingMusic.value = value;
  set songSliderValue(value) => _songSliderValue.value = value;
  set giftCount(value) => _giftCount.value = value;
  set selectedUserGift(ZegoUser value) => _selectedUserGift.value = value;
  set roomMempersPagination(PaginationEntity value) =>
      _roomMempersPagination.value = value;
  set roomMempers(List<UserEntity> value) => _roomMempers.value = value;
  set loadingRoomMempers(value) => _loadingRoomMempers.value = value;
  set loadingRoomMempersPaginate(value) =>
      _loadingRoomMempersPaginate.value = value;
  set mutedListLocally(List<String> value) => _mutedListLocally.value = value;
  set mutedList(List<String> value) => _mutedList.value = value;
  set kickOutPermanently(value) => _kickOutPermanently.value = value;
  set requestMicList(List<ZegoUser> value) => _requestMicList.value = value;
  set apiUsers(List<UserEntity> value) => _apiUsers.value = value;
  set userProfile(RoomUserEntity value) => _userProfile.value = value;
  set loadingCancelFriend(value) => _loadingCancelFriend.value = value;
  set loadingSendFriend(value) => _loadingSendFriend.value = value;
  set loadingCancelMempership(value) => _loadingCancelMempership.value = value;
  set loadingFireUser(value) => _loadingFireUser.value = value;
  set loadingJoinAsMemper(value) => _loadingJoinAsMemper.value = value;
  set loadingSendGift(value) => _loadingSendGift.value = value;
  set loadingSendMessage(value) => _loadingSendMessage.value = value;
  set loadingReport(value) => _loadingReport.value = value;
  set loadingUpdateUserRole(value) => _loadingUpdateUserRole.value = value;
  set enableTag(value) => _enableTag.value = value;
  set loadingSearch(value) => _loadingSearch.value = value;
  set searchUsers(List<UserEntity> value) => _searchUsers.value = value;

  backToMainRoute() {
    closeAndDisposeRoom();
    Get.until((route) {
      if (Get.currentRoute == AppRoutes.mainRoute) {
        return true;
      }
      return false;
    });
  }

  joinRoom() async {
    loadingJoinRoom = true;
    if (await AppPermission.requestMicPermission()) {
      if (Platform.isAndroid) {
        await startSilentAudio();
      }
      (await _joinRoomUseCase.execute(roomId)).fold(
        (l) {
          loadingJoinRoom = false;
          backToMainRoute();
          showSnackBarWidget(message: l.message);
        },
        (r) async {
          room = r;
          if (r.zegoToken.isEmpty) {
            backToMainRoute();
            showSnackBarWidget(message: AppStrings.unknown);
            return;
          }
          zegoToken = r.zegoToken;
          if (r.isFierd) {
            backToMainRoute();
            showSnackBarWidget(message: AppStrings.youAreKickedOutOfThisRoom);
            return;
          }
          getGiftList();
          getRoomMempers();
          lockRoomController.text = room.lockCode;
          lockedSeatList =
              List.generate(room.microphonesCount.toInt(), (index) {
            return LockedSeatLocalModel(
                seatIndex: index, seatValue: false, userID: '');
          });
          // await generateZegoToken();
          await initZego();
        },
      );
    } else {
      loadingJoinRoom = false;
    }
  }

  generateZegoToken() async {
    final params = GenerateZegoTokenParams(
      roomId: roomId,
      userId: user.id,
    );
    (await _generateZegoTokenUseCase.execute(params)).fold(
      (l) {
        loadingJoinRoom = false;
        backToMainRoute();
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        zegoToken = r.zegoToken;
        await initZego();
      },
    );
  }

  leaveRoom() async {
    (await _leaveRoomUseCase.execute(roomId));
  }
//   Future<void> sendRoleChangeRequest( ) async {
//   final dataToSend = {
//     'user_id': userProfile.id,
//     'text': 'test',
//   };

//   await ZEGOSDKManager().zimService.setRoomAttributes(
//     {
//       'show_message': 'true',
//       'data': jsonEncode(dataToSend),
//     },
//     isForce: true,
//     isUpdateOwner: true,
//   );
// }

  sendTestMessageToUser() async {
    final attributes = {
      'show_message': 'true',
      'data': jsonEncode({
        'user_id': userProfile.id.toString(),
        'text': 'test',
      }),
    };

    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
    Get.back();
  }

  Future<void> sendResultToUser(String userId, String text) async {
    final dataToSend = {
      'user_id': userId,
      'text': text,
    };

    final encodedData = jsonEncode(dataToSend);
    print('🔔 ارسال بيانات show_result: $encodedData');

    await ZEGOSDKManager().zimService.setRoomAttributes({
      'show_result': 'true',
      'data': encodedData,
    });
  }

  initZego() async {
    try {
      await ZEGOSDKManager()
          .init(appID, appSign, scenario: ZegoScenario.HighQualityChatroom);
      await ZEGOSDKManager().connectUser(user.id.toString(), user.name);
      final zimService = ZEGOSDKManager().zimService;
      final expressService = ZEGOSDKManager().expressService;
      await loginRoom();
      ZegoLiveAudioRoomManager().seatList = List.generate(
        room.microphonesCount.toInt(),
        (index) => ZegoLiveAudioRoomSeat(index),
      );

      users.add(ZegoUser(
        user.id.toString(),
        user.name,
      ));
      subscriptions.addAll([
        expressService.roomStateChangedStreamCtrl.stream.listen(
          onExpressRoomStateChanged,
        ),
        zimService.roomStateChangedStreamCtrl.stream.listen(
          onZIMRoomStateChanged,
        ),
        zimService.connectionStateStreamCtrl.stream.listen(
          onZIMConnectionStateChanged,
        ),
        zimService.roomAttributeUpdateStreamCtrl.stream.listen(
          (event) async {
            if (event.updateInfo.roomAttributes.containsKey("locked_list")) {
              final data =
                  jsonDecode(event.updateInfo.roomAttributes['list'] ?? '{}');

              lockedSeatList.clear();
              data.forEach((element) {
                lockedSeatList.add(LockedSeatLocalModel.fromJson(element));
              });
            }

//           if (event.updateInfo.roomAttributes.containsKey("show_message")) {
//   final data = jsonDecode(event.updateInfo.roomAttributes['data'] ?? '{}');
//   final targetUserId = data['user_id'];
//   final text = data['text'];

//   if (targetUserId == user.id.toString()) {
//     await showDialog(
//       context: Get.context!,
//       builder: (_) => AlertDialog(
//         title: const Text("📩 رسالة جديدة"),
//         content: Text(text),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text("رفض"),
//           ),
//         TextButton(
//   onPressed: () async {
//     Get.back();
//     final nextRole = getNextRole(room.role, isForApi: true);
//     final params = UpdateRoleParams(
//       chatRoomId: roomId,
//       userId: user.id.toString(),
//       role: nextRole,
//     );

//     final result = await _updateUserRoleUseCase.execute(params);

//     result.fold(
//       (l) => print('❌ فشل التحديث'),
//       (r) async {
//         await updateZegoUserRole(params);
//         await getRoomMempers();
// TextButton(
//   onPressed: () async {
//     Get.back();

//     final nextRole = getNextRole(room.role, isForApi: true);

//     final params = UpdateRoleParams(
//       chatRoomId: roomId,
//       userId: user.id.toString(),
//       role: nextRole,
//     );

//     final result = await _updateUserRoleUseCase.execute(params);

//     result.fold(
//       (l) => print('❌ فشل التحديث'),
//       (r) async {
//         await updateZegoUserRole(params);
//         await getRoomMempers();
//         room = room.updateRole(params.role ?? 'guest');
//         _room.refresh();
//       },
//     );
//   },
//   child: const Text("قبول"),
// );

//         room = room.updateRole(params.role ?? 'guest');
//         _room.refresh();
//       },
//     );
//   },
//   child: const Text("قبول"),
// ),

//         ],
//       ),
//     );
//   }

//   await ZEGOSDKManager().zimService.deleteRoomAttributes(['show_message']);
// }
            if (event.updateInfo.roomAttributes.containsKey("show_result")) {
              final rawData = event.updateInfo.roomAttributes['data'];

              if (rawData != null && rawData.isNotEmpty) {
                final data = jsonDecode(rawData);

                final targetUserId = data['user_id'];
                final resultText = data['text'];
                if (targetUserId == user.id.toString()) {
                  showSnackBarWidget(
                    message: resultText,
                    snackPosition: SnackPosition.BOTTOM,
                    color: ColorManager.green,
                    second: 5,
                  );
                }
              }
              await ZEGOSDKManager()
                  .zimService
                  .deleteRoomAttributes(['show_result', 'data']);
            }

            if (event.updateInfo.roomAttributes.containsKey("show_message")) {
              final data =
                  jsonDecode(event.updateInfo.roomAttributes['data'] ?? '{}');
              final targetUserId = data['user_id'];
              final text = data['text'];
              print('test');
              if (targetUserId == user.id.toString()) {
                await showDialog(
                  context: Get.context!,
                  builder: (_) => AcceptRoleDialog(message: text),
                );
              }

              await ZEGOSDKManager()
                  .zimService
                  .deleteRoomAttributes(['show_message']);
            }

            if (event.updateInfo.roomAttributes.containsKey("settings")) {
              final data =
                  jsonDecode(event.updateInfo.roomAttributes['data'] ?? '{}');
              final settings = RoomUpdateSettingsModel.fromJson(data);
              room = room.copyFromSettings(settings);

              for (var element in micUsers.keys) {
                if (int.parse(element) > settings.roomMicsCount) {
                  await ZegoLiveAudioRoomManager()
                      .removeSpeakerFromSeat(element);
                }
              }

              if (ZegoLiveAudioRoomManager().seatList.length >
                  room.microphonesCount.toInt()) {
                for (int i = ZegoLiveAudioRoomManager().seatList.length;
                    i > room.microphonesCount.toInt();
                    i--) {
                  ZegoLiveAudioRoomManager().seatList.removeAt(i - 1);
                  lockedSeatList.removeAt(i - 1);
                }
              }
              if (ZegoLiveAudioRoomManager().seatList.length <
                  room.microphonesCount.toInt()) {
                for (int i = ZegoLiveAudioRoomManager().seatList.length;
                    i < room.microphonesCount.toInt();
                    i++) {
                  ZegoLiveAudioRoomManager()
                      .seatList
                      .add(ZegoLiveAudioRoomSeat(i));
                  lockedSeatList.add(
                    LockedSeatLocalModel(
                      seatIndex: i,
                      seatValue: false,
                      userID: '',
                    ),
                  );
                }
              }
              for (var seatIndex in room.micStatues) {
                lockSeat(seatIndex, withBack: false);
              }
              for (var element in micUsers.keys) {
                if (int.parse(element) > settings.roomMicsCount.toInt()) {
                  await ZegoLiveAudioRoomManager()
                      .removeSpeakerFromSeat(element);
                }
              }
            }
            if (event.updateInfo.roomAttributes.containsKey("clear_messages")) {
              messages.clear();
            }
            if (event.updateInfo.roomAttributes.containsKey("update_role")) {
              final data =
                  jsonDecode(event.updateInfo.roomAttributes['data'] ?? '{}');
              final role = UpdateRoleParams.fromJson(data);
              if (role.userId == user.id.toString()) {
                room = room.updateRole(
                  room.role,
                );
                if (role.role == 'guest') {
                  showSnackBarWidget(
                      message:
                          "${AppStrings.yourRoleHasBeenUpdatedTo}: ${getCurrentRole(role.role ?? '')}");
                }
                if (role.role == 'member') {
                  showSnackBarWidget(
                    message:
                        "${AppStrings.yourRoleHasBeenUpdatedTo}: ${getCurrentRole(role.role ?? '')}",
                    color: ColorManager.green,
                  );
                }
                if (role.role == 'admin') {
                  showSnackBarWidget(
                    message:
                        "${AppStrings.yourRoleHasBeenUpdatedTo}: ${getCurrentRole(role.role ?? '')}",
                    color: ColorManager.green,
                  );
                }
                newRoom.refresh();
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['update_role']);
            }
            if (event.updateInfo.roomAttributes.containsKey("c")) {
              final data = event.updateInfo.roomAttributes;
              if (isOwner()) {
                if (data['data'] != null || data['data']!.isNotEmpty) {
                  showSnackBarWidget(message: data['data']!);
                }
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['c']);
            }
            if (event.updateInfo.roomAttributes.containsKey("j")) {
              final data = event.updateInfo.roomAttributes;
              if (isOwner()) {
                if (data['data'] != null || data['data']!.isNotEmpty) {
                  showSnackBarWidget(message: data['data'] ?? '');
                }
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['j']);
            }
            if (event.updateInfo.roomAttributes.containsKey("request_mic")) {
              final data = event.updateInfo.roomAttributes;
              if (isAdmin()) {
                if (data['user_id'] != null || data['user_id']!.isNotEmpty) {
                  if (requestMicList
                      .where((element) => element.userID == data['user_id'])
                      .isEmpty) {
                    requestMicList.add(ZegoUser(
                        data['user_id'] ?? '', data['user_name'] ?? ''));

                    showSnackBarWidget(
                      message:
                          '${AppStrings.askedToSpeakOnTheMicrophone(data['user_name'] ?? '')} 👋',
                      snackPosition: SnackPosition.TOP,
                      color: ColorManager.green,
                      second: 5,
                    );
                  }
                }
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['request_mic']);
            }
            if (event.updateInfo.roomAttributes.containsKey("accept_mic")) {
              final data = event.updateInfo.roomAttributes;
              if (data['user_id'] == user.id.toString()) {
                final index = lockedSeatList
                    .indexWhere((element) => element.seatValue == true);
                await unlockSeat(index, withBack: false);

                ZegoLiveAudioRoomManager().takeSeat(index);
                showSnackBarWidget(
                  message: AppStrings.yourRequestHasBeenAcceptedYouCanNowTalk,
                  color: ColorManager.green,
                );
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['accept_mic']);
            }
            if (event.updateInfo.roomAttributes.containsKey("reject_mic")) {
              final data = event.updateInfo.roomAttributes;
              if (data['user_id'] == user.id.toString()) {
                showSnackBarWidget(
                    message: AppStrings.yourRequestToSpeakWasDenied);
              }
              ZEGOSDKManager().zimService.deleteRoomAttributes(['reject_mic']);
            }

            if (!event.updateInfo.roomAttributes.containsKey("locked_list") &&
                !event.updateInfo.roomAttributes.containsKey("settings") &&
                !event.updateInfo.roomAttributes
                    .containsKey("clear_messages") &&
                !event.updateInfo.roomAttributes.containsKey("update_role") &&
                !event.updateInfo.roomAttributes.containsKey("c") &&
                !event.updateInfo.roomAttributes.containsKey("j") &&
                !event.updateInfo.roomAttributes.containsKey("request_mic") &&
                !event.updateInfo.roomAttributes.containsKey("reject_mic") &&
                !event.updateInfo.roomAttributes.containsKey("accept_mic")) {
              if (event.updateInfo.action ==
                  ZIMRoomAttributesUpdateAction.delete) {
                micUsers.remove(event.updateInfo.roomAttributes.keys.first);
              } else {
                micUsers.addAll(event.updateInfo.roomAttributes);
              }
            }
          },
        ),
        expressService.roomUserListUpdateStreamCtrl.stream.listen((event) {
          if (event.updateType == ZegoUpdateType.Add) {
            roomNotificationList.insert(
                roomNotificationList.length,
                NewUserEntryNotification(
                  user: event.userList.first,
                  onDelete: () {
                    roomNotificationList.removeAt(0);
                  },
                ));
            users.addAll(event.userList);
            getApiUsers();
          } else {
            apiUsers.removeWhere((element) =>
                element.id.toString() == event.userList.first.userID);
            users.removeWhere(
                (element) => element.userID == event.userList.first.userID);
          }
        }),
      ]);
      users.addAll(
        expressService.userInfoList
            .map((e) => ZegoUser(e.userID, e.userName))
            .toList(),
      );
      getApiUsers();
      ZegoExpressEngine.instance.setAECMode(ZegoAECMode.Aggressive);
      ZegoExpressEngine.instance.setANSMode(ZegoANSMode.Aggressive);
      ZegoExpressEngine.instance.enableAEC(true);
      ZegoExpressEngine.instance.enableANS(true);
      ZegoExpressEngine.instance.enableAGC(true);
      ZegoExpressEngine.instance.enableTransientANS(true);
      ZegoExpressEngine.instance.setCaptureVolume(75);
      final streamList = await ZegoExpressEngine.instance
          .getRoomStreamList(roomId, ZegoRoomStreamListType.All);

      for (var element in streamList.playStreamList) {
        ZegoExpressEngine.instance.startPlayingStream(element.streamID);
      }

      ZegoExpressEngine.onRoomStreamUpdate =
          (roomID, state, streamList, extra) {
        if (state == ZegoUpdateType.Add) {
          for (var element in streamList) {
            ZegoExpressEngine.instance.startPlayingStream(element.streamID);
            if (mutedListLocally
                    .any((userID) => userID == element.user.userID) ||
                mutedList.any((userID) => userID == element.user.userID)) {
              ZegoExpressEngine.instance
                  .mutePlayStreamAudio(element.streamID, true);
            }
          }
        } else {
          for (var element in streamList) {
            ZegoExpressEngine.instance.stopPlayingStream(element.streamID);
          }
        }
      };

      ZegoExpressEngine.instance.startSoundLevelMonitor();
      ZegoExpressEngine.onCapturedSoundLevelUpdate = (event) {
        if (!micState) {
          isSpeaking = false;
          update();
          return;
        }
        isSpeaking = event > 1;
        update();
      };

      ZegoExpressEngine.onRemoteSoundLevelUpdate = (value) {
        soundLevel = value;
        _soundLevel.refresh();
        update();
      };
      ZegoExpressEngine.onIMRecvBroadcastMessage =
          (String roomID, List<ZegoBroadcastMessageInfo> messageList) {
        final message = messageList.last;
        messages.insert(
          messages.length,
          MessageWidget(
            onConfirmDelete: () {
              enableScroll = true;
              focusNode.requestFocus();
              if (!messageController.text.contains(
                  "@${message.fromUser.userName.replaceAll(" ", "_")}\n")) {
                messageController.text +=
                    "@${message.fromUser.userName.replaceAll(" ", "_")}\n";
              }
            },
            message: MessageWidgetModel(
              user: message.fromUser,
              message: MessageLocalModel.fromJson(jsonDecode(message.message))
                  .message,
              image:
                  MessageLocalModel.fromJson(jsonDecode(message.message)).image,
            ),
          ),
        );
        animateToLast();
      };
      await createMediaPlayer();
      initGift();
      for (var seatIndex in room.micStatues) {
        lockSeat(seatIndex, withBack: false);
      }
      if (Get.isRegistered<RoomsController>()) {
        Get.find<RoomsController>().getGeneralPage();
        Get.find<RoomsController>().getPopularRooms();
        Get.find<RoomsController>().getMyOwnPage();
      }
      ZegoExpressEngine.instance.setAudioSource(
        ZegoAudioSourceType.Microphone,
        config: ZegoAudioSourceMixConfig(
          enableMixSystemPlayout: false,
        ),
        channel: ZegoPublishChannel.Main,
      );
      ZegoExpressEngine.instance
          .setAudioCaptureStereoMode(ZegoAudioCaptureStereoMode.Always);
      ZegoExpressEngine.instance
          .setAudioDeviceMode(ZegoAudioDeviceMode.Communication3);
    } catch (e) {
      backToMainRoute();
      showSnackBarWidget(message: AppStrings.unknown);
      // log(e.toString());
    }
  }

  void onExpressRoomStateChanged(ZegoRoomStateEvent event) {
    debugPrint('AudioRoomPage:onExpressRoomStateChanged: $event');

    if ((event.reason == ZegoRoomStateChangedReason.KickOut) ||
        (event.reason == ZegoRoomStateChangedReason.ReconnectFailed) ||
        (event.reason == ZegoRoomStateChangedReason.LoginFailed)) {
      backToMainRoute();
    }

    if (event.reason == ZegoRoomStateChangedReason.Reconnecting) {}
    if (event.reason == ZegoRoomStateChangedReason.Reconnected ||
        event.reason == ZegoRoomStateChangedReason.Logined) {}
  }

  void onZIMRoomStateChanged(ZIMServiceRoomStateChangedEvent event) {
    debugPrint('AudioRoomPage:onZIMRoomStateChanged: $event');
    if ((event.event == ZIMRoomEvent.success) ||
        (event.state == ZIMRoomState.connected)) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }

    if (event.state == ZIMRoomState.disconnected) {
      backToMainRoute();
    }

    if (event.state == ZIMRoomState.connecting) {
      Get.dialog(const ErrorConnectionDialog(), barrierDismissible: false);
    }
  }

  void onZIMConnectionStateChanged(
    ZIMServiceConnectionStateChangedEvent event,
  ) {
    debugPrint('AudioRoomPage:onZIMConnectionStateChanged: $event');
    if (event.state == ZIMConnectionState.disconnected) {
      backToMainRoute();
    }
  }

  void onRoomAttributeUpdateStreamCtrl(
      ZIMServiceRoomAttributeUpdateEvent event) {
    if (event.updateInfo.action == ZIMRoomAttributesUpdateAction.delete) {
      micUsers.remove(event.updateInfo.roomAttributes.keys.first);
    } else {
      micUsers.addAll(event.updateInfo.roomAttributes);
    }
  }

  loginRoom() async {
    await ZegoLiveAudioRoomManager()
        .loginRoom(
      roomId,
      ZegoLiveAudioRoomRole.audience,
      token: zegoToken,
    )
        .then((result) {
      if (result.errorCode == 0) {
        // log("Login Room Success");
      }
    }).onError(
      (error, stackTrace) {
        // log('error $error $stackTrace');
      },
    );
    messages.insert(
      0,
      GeneralNotificationMessage(
        content: room.helloMesaage,
      ),
    );
    messages.insert(
      0,
      GeneralNotificationMessage(
        content: room.generalNotificationContent,
        isWelcomMessage: true,
      ),
    );
    loadingJoinRoom = false;
  }

  createMediaPlayer() async {
    print("createMediaPlayer");
    if (mediaPlayer == null) {
      print("mediaPlayer === null");
      await ZegoExpressEngine.instance.createMediaPlayer().then((value) async {
        if (value != null) {
          mediaPlayer = value;
          mediaPlayer?.enableAux(true);
        } else {
          await createMediaPlayer();
        }
      });
    }
  }

  logoutRoom() async {
    await ZEGOSDKManager().disconnectUser();

    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }

  updateRoomSettings(RoomUpdateSettingsModel model) async {
    final attributes = {
      'settings': 'true',
      "data": jsonEncode(model.toJson()),
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
  }

  lockRoom() async {
    if (loadingLockRoom) return;
    if (lockRoomFormKey.currentState!.validate()) {
      loadingLockRoom = true;
      final params = LockRoomParams(
        code: lockRoomController.text,
        roomID: roomId,
      );
      (await _lockRoomUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          room.lockCode = lockRoomController.text;
          if (Get.isDialogOpen == true) {
            Get.back();
          }
        },
      );
      loadingLockRoom = false;
    }
  }

  unlockRoom() async {
    if (loadingLockRoom) return;
    loadingLockRoom = true;
    (await _unlockRoomUseCase.execute(roomId)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        room.lockCode = '';
        lockRoomController.clear();
        if (Get.isDialogOpen == true) {
          Get.back();
        }
      },
    );
    loadingLockRoom = false;
  }

  sendRoomReport() async {
    if (loadingReport) return;
    if (reportFormKey.currentState!.validate()) {
      loadingReport = true;
      Get.back();
      final params = RoomReportParams(
        roomID: roomId,
        type: 'room',
        content: reportRoomController.text,
      );
      (await _reportUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          showSnackBarWidget(
            message: AppStrings
                .yourComplaintWillBeReviewedAndYouWillBeContactedQuickly,
            color: ColorManager.green,
          );
        },
      );
      loadingReport = false;
    }
  }

  /// GIFT

  void initGift() {
    ZegoGiftController().service.recvNotifier.addListener(onGiftReceived);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ZegoGiftController().service.init(
            appID: appID,
            localUserID: ZEGOSDKManager().currentUser!.userID,
            localUserName: 'user_${ZEGOSDKManager().currentUser!.userName}',
          );
    });
  }

  void uninitGift() {
    ZegoGiftController().clearPlayingList();
    ZegoGiftController().service.recvNotifier.removeListener(onGiftReceived);
    ZegoGiftController().service.uninit();
  }

  onGiftReceived() async {
    print("on gift received");
    final receivedGiftCommand = ZegoGiftController().service.recvNotifier.value;
    print("on gift received value =${receivedGiftCommand} ");
    print('//test123 on gift received  ');
    print('//test123 on gift received  ');
    print(
        '//test123 on gift received ${appController.user.goldValue.toString()}');
    print('//test123 on gift received ${room.membershipFee}');
    if (receivedGiftCommand == null) {
      return;
    }

    final gift =
        RoomSendGiftModel.fromJson(jsonDecode(receivedGiftCommand.giftName));
    final giftPath = await getPathFromAssetOrCache(gift.giftFile);
    messages.insert(messages.length, GiftMessageWidget(gift: gift));
    animateToLast();
    print(gift.giftCount);
    roomNotificationList.insert(
        roomNotificationList.length,
        GiftNotification(
          userName: gift.sender.name,
          onDelete: () {
            roomNotificationList.removeAt(0);
          },
        ));
    if (gift.giftFile.contains('svga')) {
      if (!svgController.isAnimating) {
        svgController.videoItem =
            await SVGAParser.shared.decodeFromBuffer(giftPath);
        displaySvgAnimatedGift = true;
        svgController.forward();
      } else {
        pendingGiftList.add(giftPath);
      }
      print('test532423799');
    } else {
      jsonGift.value = gift.giftFile.toString();
      // showLottie.value = true;
      // print(jsonGift);
      // messages.add(GiftMessageWidget(gift: gift));
      // animateToLast();
      //  messages.add(GiftMessageWidget(gift: gift));
      // animateToLast();
      final newId = generateRandomString(12); // أو أي توليد مميز
      print("Adding gift with id: $newId");
      giftUrls.add({'url': jsonGift.value.toString(), 'id': newId});
      showLottie.value = true;
      if (!animationController.isAnimating) {
        _startCurrentAnimation();
      }
    }
  }

  getGiftList() async {
    loadingGetGift = true;
    (await _getGiftListUseCase.execute('')).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        gifts = r;

        for (final element in gifts) {
          giftsCategories.addIf(
            giftsCategories
                .where(
                  (cat) => cat.id == element.category.id,
                )
                .isEmpty,
            element.category,
          );
        }
      },
    );
    loadingGetGift = false;
  }

  onSendGift() async {
    print('//test123');
    print('//test123${appController.user.goldValue.toString()}');
    print('//test123${room.membershipFee}');
    if (loadingSendGift) return;

    if (appController.user.goldValue < room.membershipFee) {
      showSnackBarWidget(message: AppStrings.thereIsNotEnoughBalance);
      return;
    }

    if (selectedGift.id == 0) {
      showSnackBarWidget(message: AppStrings.pleaseSelectGiftFirst);
      return;
    }

    if (micUsers.isEmpty && selectedUserGift.userID == AppStrings.micsUser) {
      showSnackBarWidget(message: AppStrings.noOneIsOnTheMicrophone);
      return;
    }

    if (checkIsRoomEmpty()) {
      showSnackBarWidget(message: AppStrings.thereIsNoOneInTheRoom);
      return;
    }

    Get.back();
    loadingSendGift = true;

    final params = SendGiftParams(
      roomID: roomId,
      type: selectedUserGift.userID == AppStrings.all
          ? 2
          : selectedUserGift.userID == AppStrings.micsUser
              ? 1
              : 0,
      giftCount: giftCount,
      giftId: selectedGift.id,
      user: (selectedUserGift.userID == AppStrings.all ||
              selectedUserGift.userID == AppStrings.micsUser)
          ? null
          : int.parse(selectedUserGift.userID),
      usersInRoom: users
          .where((e) => e.userID != user.id.toString())
          .map((e) => e.userID)
          .toList(),
      usersOnMic:
          micUsers.values.where((e) => e != user.id.toString()).toList(),
    );

    (await _sendRoomGiftUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        final gift = RoomSendGiftModel(
          giftFile: selectedGift.giftFile,
          giftImage: selectedGift.giftImg,
          sender: GiftUser(name: user.name, id: user.id),
          giftCount: giftCount,
          recevier: (selectedUserGift.userID == AppStrings.all ||
                  selectedUserGift.userID == AppStrings.micsUser)
              ? null
              : GiftUser(
                  name: selectedUserGift.userName,
                  id: int.parse(selectedUserGift.userID)),
          giftType: selectedUserGift.userID == AppStrings.all
              ? 2
              : selectedUserGift.userID == AppStrings.micsUser
                  ? 1
                  : 0,
        );

        ZegoGiftController().addToPlayingList(
          ZegoGiftData(giftPath: jsonEncode(gift.toJson())),
        );

        final success = await ZegoGiftController()
            .service
            .sendGift(giftName: jsonEncode(gift.toJson()));

        if (success) {
          final giftPath = await getPathFromAssetOrCache(selectedGift.giftFile);
          selectedGift = GiftModel().toDomain();
          giftCount = 1;
          selectedUserGift = ZegoUser(AppStrings.all, AppStrings.all);
          if (isSvg == true) {
            if (!svgController.isAnimating) {
              svgController.videoItem =
                  await SVGAParser.shared.decodeFromBuffer(giftPath);
              displaySvgAnimatedGift = true;
              svgController.forward();
            } else {
              pendingGiftList.add(giftPath);
            }
            messages.add(GiftMessageWidget(gift: gift));
            animateToLast();
          } else {
            messages.add(GiftMessageWidget(gift: gift));
            animateToLast();
            final newId = generateRandomString(12);
            print("Adding gift with id: $newId");
            giftUrls
                .add({'url': gift.giftFile.toString(), 'id': newId.toString()});
            print(newId);
            print(gift.giftFile.toString());
            showLottie.value = true;
            if (!animationController.isAnimating) {
              _startCurrentAnimation();
            }
          }
        }
      },
    );

    loadingSendGift = false;
  }

  onChangeGiftCount(value) {
    giftCount = value;
  }

  generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  onChangeGiftUser(value) {
    selectedUserGift = value;
  }

  sendGiftToUser() {
    selectedUserGift = ZegoUser(
      userProfile.id.toString(),
      userProfile.name,
    );
    Get.back();
    Get.bottomSheet(const GiftsBottomSheet());
  }

  /// GIFT

  /// MICS Managment

  takeMic(int index) async {
    Get.back();
    for (var element in ZegoLiveAudioRoomManager().seatList) {
      if (element.currentUser.value?.userID == user.id.toString()) {
        await ZegoLiveAudioRoomManager().removeSpeakerFromSeat(
          user.id.toString(),
        );
      }
    }
    await ZegoLiveAudioRoomManager().takeSeat(index, isForce: true);
    isTakingSeat = true;
    micState = true;
  }

  lockSeat(int seatIndex, {bool withBack = true}) async {
    if (withBack) {
      Get.back();
    }
    lockedSeatList.firstWhereOrNull(
      (element) {
        if (element.seatIndex == seatIndex) {
          element.seatValue = true;

          return element.seatIndex == seatIndex;
        }
        return false;
      },
    );
    final attributes = {
      'locked_list': 'true',
      "list": jsonEncode(lockedSeatList.map((e) => e.toJson()).toList()),
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
    if (isAdmin()) {
      lockMic(seatIndex);
    }
  }

  unlockSeat(int seatIndex, {bool withBack = true}) async {
    if (withBack) {
      Get.back();
    }
    lockedSeatList.firstWhereOrNull(
      (element) {
        if (element.seatIndex == seatIndex) {
          element.seatValue = false;
          return element.seatIndex == seatIndex;
        }
        return false;
      },
    );
    final attributes = {
      'locked_list': 'true',
      "list": jsonEncode(lockedSeatList.map((e) => e.toJson()).toList()),
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
    unlockMic(seatIndex);
  }

  toggleMic() {
    micState = !micState;
    ZEGOSDKManager().expressService.turnMicrophoneOn(micState, roomId: roomId);
  }

  toggleMuteAllLocally() async {
    if (!isMuteAll) {
      ZegoExpressEngine.instance.muteAllPlayStreamAudio(true);
      isMuteAll = true;
    } else {
      ZegoExpressEngine.instance.muteAllPlayStreamAudio(false);
      isMuteAll = false;
    }
  }

  leaveMic(int index) async {
    await ZegoLiveAudioRoomManager().leaveSeat(index);
    micState = false;
    isTakingSeat = false;
    Get.back();
  }

  lockMic(int index) async {
    final params = LockUnlockMicParams(micID: index, roomID: roomId);
    (await _lockMicUseCase.execute(params));
  }

  unlockMic(int index) async {
    final params = LockUnlockMicParams(micID: index, roomID: roomId);
    (await _unlockMicUseCase.execute(params));
  }

  muteUnMuteUserLocaly() {
    final userID = userProfile.id.toString();
    final streamID = "${roomId}_${userID}_speaker";
    if (mutedListLocally.any((element) => element == userID)) {
      ZegoExpressEngine.instance.mutePlayStreamAudio(streamID, false);
      mutedListLocally.removeWhere((element) => element == userID);
    } else {
      ZegoExpressEngine.instance.mutePlayStreamAudio(streamID, true);
      mutedListLocally.add(userID);
    }
    _mutedListLocally.refresh();
  }

  muteUnMuteUser() async {
    Get.back();
    final user =
        apiUsers.firstWhereOrNull((element) => element.id == userProfile.id);
    if (user != null) {
      if (appController.vipActive &&
          user.privileges.data.disableMuteAndFiering.id != 0) {
        showSnackBarWidget(message: AppStrings.youCannotMuteThisPremiumUser);
        return;
      }
    }

    final userID = userProfile.id.toString();
    bool isMute = mutedList.any((element) => element == userID);
    await ZegoLiveAudioRoomManager().muteSpeaker(
      userID,
      !isMute,
    );
    if (isMute) {
      mutedList.remove(userID);
    } else {
      mutedList.add(userID);
    }
  }

  requestMic() async {
    Get.back();
    final attributes = {
      'request_mic': 'true',
      "user_id": user.id.toString(),
      "user_name": user.name,
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
  }

  approveSpeakToMic(String userID) async {
    final attributes = {
      'accept_mic': 'true',
      "user_id": userID,
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
    requestMicList.removeWhere((element) => element.userID == userID);
  }

  rejectSpeakToMic(String userID) async {
    final attributes = {
      'reject_mic': 'true',
      "user_id": userID,
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
    requestMicList.removeWhere((element) => element.userID == userID);
  }

  /// MICS Managment

  /// Users

  String getUserImage(String id) {
    return 'https://arablivebucket.s3.eu-north-1.amazonaws.com/users/avatar/$id.webp';
  }

  Widget userErrorImageWidget({double? width, double? height}) {
    return AppImage(
      image: Constants.userErrorWidget,
      width: width,
      height: height,
    );
  }

  openProfileBottomSheet(String id) {
    if (id == user.id.toString()) {
      return;
    }
    getUserProfile(int.parse(id));
    Get.bottomSheet(const UserProfileBottomSheet());
  }

  getUserProfile(int id) async {
    print('test123userProfile');
    loadingGetProfile = true;
    userProfile = RoomUserModel().toDomain();
    final params = RoomUserParams(userID: id.toString(), roomID: roomId);
    (await _getRoomUserUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userProfile = r;
      },
    );
    loadingGetProfile = false;
  }

  bool isOwner() => room.role == "owner";
  bool isAdmin() => room.role == "admin" || room.role == "owner";

  bool checkIsRoomEmpty() {
    return users
        .where((element) => element.userID != user.id.toString())
        .toList()
        .isEmpty;
  }

  String getCurrentRole(String role) {
    if (role == 'guest') {
      return AppStrings.guest;
    }
    if (role == 'member') {
      return AppStrings.member;
    }
    if (role == 'admin') {
      return AppStrings.admin;
    }
    if (role == 'owner') {
      return AppStrings.owner;
    }
    return '';
  }

  String getNextRole(String role, {bool isForApi = false}) {
    if (role == 'guest') {
      return isForApi ? 'member' : AppStrings.member;
    }
    if (role == 'member') {
      return isForApi ? 'admin' : AppStrings.admin;
    }
    if (role == 'admin') {
      return isForApi ? 'guest' : AppStrings.guest;
    }
    return '';
  }

  updateUserRole() async {
    if (loadingUpdateUserRole) return;
    loadingUpdateUserRole = true;
    Get.back();
    final params = UpdateRoleParams(
      chatRoomId: roomId,
      userId: userProfile.id.toString(),
      role: getNextRole(userProfile.role, isForApi: true),
    );
    (await updateUserRoleUseCase.execute(params)).fold(
      (l) {},
      (r) {
        updateZegoUserRole(params);
        getRoomMempers();
      },
    );
    loadingUpdateUserRole = false;
  }

  updateZegoUserRole(UpdateRoleParams params) async {
    final attributes = {
      'update_role': 'true',
      "data": jsonEncode(params.toJson()),
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
  }

  kickoutUser() async {
    Get.back();
    final user =
        apiUsers.firstWhereOrNull((element) => element.id == userProfile.id);
    if (user != null) {
      if (appController.vipActive &&
          user.privileges.data.disableMuteAndFiering.id != 0) {
        kickOutPermanently = false;
        showSnackBarWidget(message: AppStrings.youCannotFireThisPremiumUser);
        return;
      }
    }
    await ZegoLiveAudioRoomManager().kickOutRoom(userProfile.id.toString());
    if (kickOutPermanently) {
      await fireUser();
    }
  }

  fireUser() async {
    if (loadingFireUser) return;
    loadingFireUser = true;
    final params = FireUserParams(
      roomID: roomId,
      type: "permenant",
      userID: userProfile.id.toString(),
    );
    (await _fireUserUseCase.execute(params)).fold(
      (l) {},
      (r) {
        kickOutPermanently = false;
      },
    );
    loadingFireUser = false;
  }

  onChangeKickoutValue(value) {
    kickOutPermanently = value;
  }

  getApiUsers() async {
    final List<String> params = [];
    for (var element in users) {
      if (!apiUsers.any((user) => user.id.toString() == element.userID)) {
        params.add(element.userID);
      }
    }
    (await _getUsersInRoomUseCase.execute(params)).fold(
      (l) {},
      (r) {
        apiUsers.clear();
        apiUsers.addAll(r);
      },
    );
  }

  sendFriendRequest() async {
    if (loadingSendFriend) {
      return;
    }
    loadingSendFriend = true;
    (await _friendRequestUseCase.execute(userProfile.id.toInt())).fold(
      (l) {},
      (r) {
        userProfile.isFollowing = true;
        _userProfile.refresh();
      },
    );
    loadingSendFriend = false;
  }

  cancelFrindRequest() async {
    if (loadingCancelFriend) {
      return;
    }
    loadingCancelFriend = true;
    (await _cancelFriendRequestUseCase.execute(userProfile.id.toInt())).fold(
      (l) {},
      (r) {
        userProfile.isFollowing = false;
        _userProfile.refresh();
      },
    );
    loadingCancelFriend = false;
  }

  getRoomMempers({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingRoomMempersPaginate = true;
    } else {
      loadingRoomMempers = true;
      roomMempers.clear();
      roomMempersPage = 1;
    }
    (await _getRoomMempersUseCase.execute({
      "id": roomId,
      "page": roomMempersPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        roomMempers.clear();
        roomMempersPage++;
        roomMempers.addAll(r.data);
        roomMempersPagination = r.pagination;
      },
    );
    loadingRoomMempers = false;
    loadingRoomMempersPaginate = false;
  }

  goToUserProfile() {
    Get.back();
    Get.toNamed(
      AppRoutes.userProfileRoute,
      arguments: {
        'id': userProfile.id,
        'isFromChat': false,
      },
    );
  }

  /// Users

  /// messages

  sendMessage() async {
    if (loadingSendMessage) return;
    if (messageController.text.isEmpty && messageImage.isEmpty) {
      return;
    }
    loadingSendMessage = true;
    if (messageImage.isNotEmpty) {
      await sendRoomMessage();
    }
    final message = MessageLocalModel(
      image: messageImage.isNotEmpty ? messageImage : null,
      message:
          messageController.text.isNotEmpty ? messageController.text : null,
    );
    ZegoExpressEngine.instance
        .sendBroadcastMessage(roomId, jsonEncode(message.toJson()))
        .then((ZegoIMSendBroadcastMessageResult result) {
      if (result.errorCode == 0) {
        messages.insert(
          messages.length,
          MessageWidget(
            onConfirmDelete: () {
              enableScroll = true;
              focusNode.requestFocus();
              if (!messageController.text
                  .contains("@${user.name.replaceAll(" ", "_")}\n")) {
                messageController.text +=
                    "@${user.name.replaceAll(" ", "_")}\n";
              }
            },
            message: MessageWidgetModel(
              user: ZegoUser(user.id.toString(), user.name),
              message: messageController.text,
              image: messageImage.isNotEmpty ? messageImage : null,
            ),
          ),
        );
        animateToLast();
        messageImage = '';
        messageController.clear();
      } else {
        showSnackBarWidget(message: AppStrings.errorWhenSendMessage);
      }
    });
    loadingSendMessage = false;
  }

  onPickMessageImage() async {
    messageImage = await pickImage() ?? '';
    enableScroll = true;
    focusNode.requestFocus();
  }

  clearMessageImage() {
    messageImage = '';
  }

  animateToLast() {
    scrollController2.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  sendRoomMessage() async {
    final params = SendRoomMessageParams(
      roomID: roomId,
      image: messageImage.isNotEmpty ? messageImage : null,
      message: messageController.text,
    );
    (await _messageUseCase.execute(params)).fold(
      (l) {},
      (r) {
        messageImage = r.image;
      },
    );
  }

  clearMessagesLocaly() {
    Get.back();
    messages.clear();
  }

  clearAllRoomMessages() async {
    Get.back();
    final attributes = {
      'clear_messages': 'true',
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
  }

  cancelMembership() async {
    if (loadingCancelMempership) return;
    loadingCancelMempership = true;
    Get.back();
    final params = UpdateRoleParams(
      chatRoomId: roomId,
      userId: user.id.toString(),
    );
    (await _cancelMembershipUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        room.role = 'guest';
        newRoom.refresh();
        sendMessageToAdminAfterJoinOrCancelMembership(
          AppStrings.userCancalHisMembership(user.name),
          true,
        );
      },
    );
    loadingCancelMempership = false;
  }

  joinAsMember() async {
    if (loadingJoinAsMemper) return;
    loadingJoinAsMemper = true;
    Get.back();
    if (appController.user.goldValue < room.membershipFee) {
      showSnackBarWidget(message: AppStrings.thereIsNotEnoughBalance);
      return;
    }
    (await _joinAsMemberUseCase.execute(roomId)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        room.role = 'member';
        newRoom.refresh();
        sendMessageToAdminAfterJoinOrCancelMembership(
          AppStrings.userBuyAMembershipInThisRoom(user.name),
          false,
        );

        appController
            .updateUserGold(appController.user.goldValue - room.membershipFee);
      },
    );
    loadingJoinAsMemper = false;
  }

  sendMessageToAdminAfterJoinOrCancelMembership(
      String message, bool isCancel) async {
    final attributes = {
      if (isCancel) 'c': 'true',
      if (!isCancel) "j": "true",
      "data": message,
    };
    await ZEGOSDKManager().zimService.setRoomAttributes(
          attributes,
          isForce: true,
          isUpdateOwner: true,
          isDeleteAfterOwnerLeft: false,
        );
  }

  /// messages

  /// Music

  onTapShowMusicPlayer() async {
    showMusicPlayer = true;
  }

  onTapHideMusicPlayer() {
    showMusicPlayer = false;
  }

  openMusicPlaylistView() {
    Get.to(() => const MusicPlaylistView());
  }

  int increaseSongLocalIndex() {
    if (currentSongIndex < songs.length - 1) {
      return currentSongIndex + 1;
    }
    return 0;
  }

  int decreaseSongLocalIndex() {
    if (currentSongIndex > 0) {
      return currentSongIndex - 1;
    }
    return songs.length - 1;
  }

  onChangeSoundValue(double value) {
    soundValue = value;
    mediaPlayer?.setPlayVolume(value.toInt());
    mediaPlayer?.setPublishVolume(value.toInt());
  }

  stopMusic() async {
    isPlayingMusic = false;
    showMusicPlayer = false;
    showMusicSound = false;
    musicPlayer.stop();
    if (await mediaPlayer?.getCurrentState() == ZegoMediaPlayerState.Playing) {
      await mediaPlayer?.stop();
    }
  }

  seekMusic(double position) async {
    songSliderValue = position;
    if (musicPlayer.playing) {
      await musicPlayer.seek(Duration(seconds: position.toInt()));
      await mediaPlayer?.seekTo((position * 1000).toInt());
    }
  }

  pauseMusic() async {
    isPlayingMusic = false;
    await musicPlayer.stop();
    if (await mediaPlayer?.getCurrentState() == ZegoMediaPlayerState.Playing) {
      await mediaPlayer?.stop();
    }
  }

  Future<void> onSkipMusicAction(bool isNext) async {
    await seekMusic(0);
    await pauseMusic();
    currentSongIndex =
        isNext ? increaseSongLocalIndex() : decreaseSongLocalIndex();
    await playMusic();
  }

  playMusic() async {
    await musicPlayer
        .setAudioSource(AudioSource.file(songs[currentSongIndex].path ?? ''));
    await mediaPlayer?.loadResource(songs[currentSongIndex].path ?? '');
    await mediaPlayer?.seekTo(musicPlayer.position.inMilliseconds);
    await mediaPlayer?.start();
    await mediaPlayer?.setPublishVolume(soundValue.toInt());
    isPlayingMusic = true;
    songDuration =
        Duration(seconds: (songs[currentSongIndex].duration ?? 0).toInt());
    await musicPlayer.play();
  }

  onTapOnMusicItem(int index) async {
    currentSongIndex = index;
    await pauseMusic();
    await seekMusic(0);
    await playMusic();
  }

  /// Music

  unUnitZego() async {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onCapturedSoundLevelUpdate = null;
    ZegoExpressEngine.onRemoteSoundLevelUpdate = null;
    ZegoExpressEngine.onIMRecvBroadcastMessage = null;
    ZegoExpressEngine.instance.stopSoundLevelMonitor();
    if (mediaPlayer != null) {
      ZegoExpressEngine.instance.destroyMediaPlayer(mediaPlayer!);
      mediaPlayer = null;
    }
    await logoutRoom();
    uninitGift();
  }

  void onGiftCompleted() {
    if (giftUrls.isNotEmpty) {
      giftUrls.removeAt(0);
    }
    if (giftUrls.isEmpty) {
      showLottie.value = false;
    }
  }

  initController(String roomID, {Map<String, dynamic>? data}) async {
    svgController = SVGAAnimationController(vsync: this);
    animationController = AnimationController(vsync: this);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        onGiftCompleted();
      }
    });
    if (data != null) {
      room.roomName = data['roomName'];
      room.referenceId = data['referenceId'];
      room.backgroundTheme = data['backgroundTheme'];
      room.roomImage = data['roomImage'];
    }
    user = Get.find<AppController>().user;
    WidgetsBinding.instance.addObserver(this);
    focusNode = FocusNode();
    musicPlayer = AudioPlayer();
    roomId = roomID;
    loadingJoinRoom = true;
    songBox = Hive.box<RoomSongModel>("RoomSongModel");
    songs = songBox.values.toList();
    await joinRoom();

    svgController.addStatusListener((status) async {
      print('test5324237');
      if (status == AnimationStatus.completed) {
        svgController.videoItem = null;
        if (pendingGiftList.isNotEmpty) {
          svgController.videoItem =
              await SVGAParser.shared.decodeFromBuffer(pendingGiftList.first);
          await Future.delayed(const Duration(seconds: 1));
          svgController.forward();
          pendingGiftList.removeAt(0);
        }
      }
    });
    musicPlayer.positionStream.listen((event) {
      songSliderValue = event.inSeconds.toDouble();
      if (musicPlayer.playing && event.inSeconds >= songDuration.inSeconds) {
        if (shouldCycle) {
          pauseMusic();
          seekMusic(0);
          playMusic();
        } else {
          onSkipMusicAction(true);
        }
      }
    });
    musicPlayer.setVolume(0);
    roomMempersScrollController.addListener(() async {
      if (roomMempersScrollController.offset ==
          roomMempersScrollController.position.maxScrollExtent) {
        if (roomMempersPagination.nextPageUrl.isNotEmpty &&
            !loadingRoomMempersPaginate) {
          await getRoomMempers(isPaginate: true);
        }
      }
    });
  }

  closeAndDisposeRoom() async {
    cleanUpRoom();
    focusNode.dispose();
    leaveRoom();
    roomId = '';
    await unUnitZego();
    musicPlayer.dispose();
    if (Platform.isAndroid) {
      stopSilentAudio();
    }
    if (Get.isRegistered<RoomsController>()) {
      Get.find<RoomsController>().getGeneralPage();
      Get.find<RoomsController>().getPopularRooms();
      Get.find<RoomsController>().getMyOwnPage();
    }
    WidgetsBinding.instance.removeObserver(this);
  }

  cleanUpRoom() {
    giftQueue.clear();
    reportRoomController.clear();
    svgController.dispose();
    animationController.dispose();
    lockRoomController.clear();
    messageController.clear();
    zegoToken = '';
    userProfile = RoomUserModel().toDomain();
    enableScroll = false;
    loadingJoinRoom = false;
    room = JoinedRoomModel().toDomain();
    micUsers.clear();
    users.clear();
    micState = true;
    isSpeaking = false;
    isTakingSeat = false;
    isMuteAll = false;
    loadingGetProfile = false;
    loadingGetGift = false;
    displaySvgAnimatedGift = false;
    soundLevel.clear();
    gifts.clear();
    giftsCategories.clear();
    pendingGiftList.clear();
    selectedGift = GiftModel().toDomain();
    lockedSeatList.clear();
    messageImage = '';
    messages.clear();
    roomNotificationList.clear();
    loadingLockRoom = false;
    showMusicPlayer = false;
    showMusicSound = false;
    songs.clear();
    currentSongIndex = 0;
    soundValue = 20.0;
    songDuration = const Duration();
    shouldCycle = false;
    isPlayingMusic = false;
    songSliderValue = 0.0;
    giftCount = 1;
    selectedUserGift = ZegoUser(AppStrings.all, AppStrings.all);
    ZEGOSDKManager().expressService.userInfoList.clear();
    ZegoLiveAudioRoomManager().seatList.clear();
    roomMempers.clear();
    roomMempersPagination = PaginationModel().toDomain();
    roomMempersPage = 1;
    mutedListLocally.clear();
    mutedList.clear();
    kickOutPermanently = false;
    requestMicList.clear();
  }

  unFocusNode() {
    focusNode.unfocus();
    enableScroll = false;
  }

  toggleTag() {
    if (users
        .where((element) => element.userID != appController.user.id.toString())
        .toList()
        .isNotEmpty) {
      enableTag = !enableTag;
    } else {
      showSnackBarWidget(message: AppStrings.thereIsNoOneInTheRoom);
    }
  }

  goToSearch() {
    roomMemperPageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  backFromSearch() {
    roomMemperPageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  onTapSearch() async {
    if (roomMemperSearchController.text.isEmpty) {
      return;
    }
    loadingSearch = true;
    (await _appSearchUseCase.execute(
      AppSearchParams(
        filter: "users",
        search: roomMemperSearchController.text,
      ),
    ))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        searchUsers = r.users;
      },
    );
    loadingSearch = false;
  }

  onSearchPageChanged(value) {
    if (value == 0) {
      searchUsers = [];
      roomMemperSearchController.clear();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      stopSilentAudio();
    }
  }

  Future<void> startSilentAudio() async {
    await _channel.invokeMethod('startSilentService');
  }

  Future<void> stopSilentAudio() async {
    await _channel.invokeMethod('stopSilentService');
  }

  @override
  void onInit() async {
    late dynamic data;
    roomId = Get.arguments['id'];
    if (Get.arguments['data'] != null) {
      data = Get.arguments['data'];
    }
    initController(roomId, data: data);
    super.onInit();
  }

  void _startCurrentAnimation() {
    if (giftUrls.isNotEmpty) {
      showLottie.value = true;
    }
  }

  @override
  void onClose() async {
    animationController.dispose();
    await closeAndDisposeRoom();
    super.onClose();
  }

  onGameClosed() async {
    isPlayingGame.value = false;
    if (isPlayingGame.value == false) {
      await cashWithdrawalController.getChargingUnits();
      print("cashWithdrawalController.unitEntity?.userGold");
      print(cashWithdrawalController.unitEntity?.userGold);
      if (cashWithdrawalController.unitEntity != null) {
        appController
            .updateUserGold(cashWithdrawalController.unitEntity!.userGold);
      }
    }
  }

  Future<void> fetchGameList({
    required String userId,
    required String roomId,
  }) async {
    final dio.Dio _dio = dio.Dio();
    isLoadingGams.value = true;
    try {
      final response = await _dio.post(
        'https://arabchatapp.com/api/game_list',
        data: {
          'user_id': userId,
          'room_id': roomId,
        },
      );

      if (response.statusCode == 200) {
        print('dfdfs');
        isLoadingGams.value = false;
        print('end');
        final jsonData = response.data;
        print(jsonData);
        gameResponse.value = GameResponse.fromJson(jsonData['data']);
        gameItems.value = GameResponse.fromJson(jsonData['data'])
            .gameList
            .map((game) => GameItem(game: game))
            .toList();
        currentGame.value =
            gameItems.value.firstWhere((e) => e.game.id == 1077).game;
      } else {
        isLoadingGams.value = false;
        Get.snackbar('Error', 'Failed: ${response.statusMessage}');
      }
    } catch (e) {
      isLoadingGams.value = false;
      Get.snackbar('Error', e.toString());
    } finally {}
    isLoadingGams.value = false;
  }

  void toggleGameStatus(GameItem g, int index, bool value) {
    gameItems[index].isActive.value = value;
    if (value) {
      addRoomGames(roomId, g.game.id.toString());
    } else {
      removeRoomGames(roomId, g.game.id.toString());
    }
  }

  Future<void> removeRoomGames(String roomId, String gameId) async {
    dio.Dio di = dio.Dio();

    AppPreferences appPreferences = instance<AppPreferences>();
    String token = await appPreferences.getUserToken();
    di.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    // Set form data
    dio.FormData formData = dio.FormData.fromMap({
      'room_id': roomId,
      'games[0]': gameId,
    });

    try {
      dio.Response response = await di.post(
        'https://arabchatapp.com/api/user/remove_room_games',
        data: formData,
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

// Dio dio = Dio();
// dio.interceptors.add(PrettyDioLogger(
//     requestHeader: true, requestBody: true, responseHeader: false));
// dio.options.headers = {
//   'Authorization': 'Bearer 1761|1XzDHn2iioI9XYNT5JPhPuAZ5DQ75uMEpalAHSpX',
//   //  'Content-Type': 'multipart/form-data',
// };
// try {
//   final response = await dio.post(
//     'https://arabchatapp.com/api/user/remove_room_games',
//     data: {
//       'room_id': roomId,
//       'games[0]': gameId,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     print(response.data);
//   } else {
//     print('Request failed: ${response.statusCode}');
//   }
// } catch (e) {
//   print('Error occurred: $e');
// }

  Future<void> addRoomGames(String roomId, String gameId) async {
    dio.Dio di = dio.Dio();
    AppPreferences appPreferences = instance<AppPreferences>();
    String token = await appPreferences.getUserToken();
    // Set headers
    di.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    // Set form data
    dio.FormData formData = dio.FormData.fromMap({
      'room_id': roomId,
      'games[0]': gameId,
    });

    try {
      dio.Response response = await di.post(
        'https://arabchatapp.com/api/user/active_room_games',
        data: formData,
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void initLottie(TickerProvider vsync, void Function()? onCompleted) {
    animationController = AnimationController(vsync: vsync);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showLottie.value = false;
        animationController.reset();
        if (onCompleted != null) onCompleted();
      }
    });
  }
}
