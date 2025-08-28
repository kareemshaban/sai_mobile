import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_permission.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/chat_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/messages_model.dart';
import 'package:new_sai/data/network/dio_factory.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/domain/use_case/chat_use_case/delete_chat_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/delivered_message_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/fetch_messages_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/mark_all_as_read_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/send_message_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/error_connection_dialog.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/pick_image_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:record/record.dart';

class ChatController extends GetxController {
  late int id;
  late int recID;
  late ChatUserInfoEntity user;
  final appController = Get.find<AppController>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final scrollController = ScrollController();
  final messageController = TextEditingController();
  final FetchMessagesUseCase _fetchMessagesUseCase =
      instance<FetchMessagesUseCase>();
  final MarkAllAsReadUseCase _markAllAsReadUseCase =
      instance<MarkAllAsReadUseCase>();
  final DeliveredMessageUseCase _deliveredMessageUseCase =
      instance<DeliveredMessageUseCase>();
  final DeleteChatUseCase _deleteChatUseCase = instance<DeleteChatUseCase>();
  final SendMessageUseCase _sendMessageUseCase = instance<SendMessageUseCase>();
  int page = 1;
  final record = AudioRecorder();
  Timer? _timer;
  PusherChannelsFlutter? pusherUser;
  String pusherChannelName = '';

  final RxBool _loadingMessages = false.obs;
  final RxBool _loadingMessagesPagination = false.obs;
  final RxBool _isFiledNotEmpty = false.obs;
  final RxList<MessagesEntity> _messages = <MessagesEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  final RxString _image = "".obs;
  final RxString _file = "".obs;
  final RxBool _isRecord = false.obs;
  final Rx<Duration> _timerDuration = const Duration().obs;
  final RxBool _loadingSendMessage = false.obs;

  bool get loadingMessages => _loadingMessages.value;
  bool get loadingMessagesPagination => _loadingMessagesPagination.value;
  bool get isFiledNotEmpty => _isFiledNotEmpty.value;
  List<MessagesEntity> get messages => _messages;
  PaginationEntity get pagination => _pagination.value;
  String get image => _image.value;
  String get file => _file.value;
  bool get isRecord => _isRecord.value;
  Duration get timerDuration => _timerDuration.value;
  bool get loadingSendMessage => _loadingSendMessage.value;

  set loadingMessages(value) => _loadingMessages.value = value;
  set loadingMessagesPagination(value) =>
      _loadingMessagesPagination.value = value;
  set isFiledNotEmpty(value) => _isFiledNotEmpty.value = value;
  set messages(List<MessagesEntity> value) => _messages.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;
  set image(value) => _image.value = value;
  set file(value) => _file.value = value;
  set isRecord(value) => _isRecord.value = value;
  set timerDuration(Duration value) => _timerDuration.value = value;
  set loadingSendMessage(value) => _loadingSendMessage.value = value;

  fetchMessage({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingMessagesPagination = true;
    } else {
      loadingMessages = true;
      page = 1;
      messages.clear();
    }
    final params = FetchMessagesParams(
      page: page,
      chatID: id,
      recID: recID,
    );
    (await _fetchMessagesUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        messages.addAll(r.data);
        pagination = r.pagination;
        page++;
      },
    );
    loadingMessages = false;
    loadingMessagesPagination = false;
  }

  markAllAsRead() async {
    final params = FetchMessagesParams(
      chatID: id,
      recID: recID,
    );
    (await _markAllAsReadUseCase.execute(params));
  }

  sendMessage() async {
    if (loadingSendMessage) {
      return;
    }
    String recordPath = '';
    if (await record.isRecording()) {
      recordPath = await record.stop() ?? '';
      cancelTimer();
    }
    if (messageController.text.isEmpty &&
        image.isEmpty &&
        file.isEmpty &&
        recordPath.isEmpty) {
      return;
    }
    final params = SendMessageParams(
      recID: recID,
      type: recordPath.isNotEmpty
          ? 'voice'
          : file.isNotEmpty
              ? "file"
              : image.isNotEmpty
                  ? "image"
                  : "text",
      message: messageController.text,
      file: recordPath.isNotEmpty
          ? recordPath
          : file.isNotEmpty
              ? file
              : image.isNotEmpty
                  ? image
                  : null,
    );
    loadingSendMessage = true;
    (await _sendMessageUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        await saveFile();
        messageController.clear();
        image = '';
        file = '';
      },
    );
    loadingSendMessage = false;
  }

  pickMessageImage() async {
    Get.bottomSheet(
      PickImageBottomSheet(
        onTapCamera: (source) async {
          image = await pickImage(imageSource: source) ?? "";
        },
        onTapGallery: (source) async {
          image = await pickImage(imageSource: source) ?? "";
        },
      ),
    );
  }

  pickFile() async {
    if (await AppPermission.requestMediaLocationPermission()) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );
      if (result != null && result.files.isNotEmpty) {
        file = result.files.first.path ?? '';
      }
    }
  }

  clearImage() {
    image = '';
  }

  clearFile() {
    file = '';
  }

  deliveredMessage(int params) async {
    (await _deliveredMessageUseCase.execute(params));
  }

  deleteChat() async {
    showAppLoadingDialog();
    (await _deleteChatUseCase.execute(id)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        Get.until((route) {
          if (Get.currentRoute == AppRoutes.roomRoute) {
            return true;
          }
          if (Get.currentRoute == AppRoutes.mainRoute) {
            return true;
          }
          return false;
        });
        if (Get.isRegistered<IncomeController>()) {
          Get.find<IncomeController>().getMyConversation();
        }
      },
    );
  }

  onTapRecord() async {
    if (await record.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      await record.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          androidConfig: AndroidRecordConfig(
            audioSource: AndroidAudioSource.mic,
          ),
          noiseSuppress: true,
          iosConfig: IosRecordConfig(
            manageAudioSession: true,
          ),
        ),
        path: '${dir.path}/audio${DateTime.now()}.wav',
      );
      startTimer();
    }
  }

  onTapCancelRecord() async {
    await record.cancel();
    cancelTimer();
  }

  startTimer() {
    timerDuration = const Duration();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timerDuration = Duration(seconds: timerDuration.inSeconds + 1);
      },
    );
  }

  cancelTimer() {
    _timer?.cancel();
  }

  initPusher() async {
    pusherUser = PusherChannelsFlutter.getInstance();
    pusherChannelName = 'private-chat-${appController.user.id}-$recID';
    try {
      await pusherUser?.init(
        apiKey: "e940514bc5df15a423c0",
        cluster: "ap1",
        onAuthorizer: onAuthorizer,
        onError: onError,
        onSubscriptionError: onSubscriptionError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onConnectionStateChange: (currentState, previousState) {
          if (currentState == 'RECONNECTING') {
            pusherUser?.connect();
            if (Get.isDialogOpen == false) {
              Get.dialog(const ErrorConnectionDialog(),
                  barrierDismissible: false);
            }
          }
          if (currentState == "CONNECTING") {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        },
      );
      await pusherUser?.subscribe(channelName: pusherChannelName);
      await pusherUser?.connect();
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic onAuthorizer(
      String pChannelName, String socketId, dynamic options) async {
    try {
      var authUrl = "/broadcasting/auth";
      var result = await (await instance<DioFactory>().getDio()).post(
        authUrl,
        data: {'socket_id': socketId, 'channel_name': pChannelName},
        options: Options(
          headers: {
            'Authorization': "Bearer ${_appPreferences.getUserToken()}"
          },
        ),
      );
      return result.data;
    } catch (e) {
      log("Error $e");
      return e;
    }
  }

  void onEvent(PusherEvent event) {
    debugPrint("pusherUser ${event.channelName} on Event: $event ");
    try {
      var eventData = jsonDecode(event.data.toString());
      if (eventData.isNotEmpty) {
        if (event.eventName == "friend.message.sent") {
          final data = MessagesModel.fromJson(eventData).toDomain();
          messages.insert(0, data);
          deliveredMessage(data.id);
        }
      }
    } catch (e) {
      debugPrint('pusherUser on event error: $e');
    }
  }

  void onError(String message, int? code, dynamic e) {
    debugPrint("pusherUser on Error: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    debugPrint(
        "pusherUser on Subscription Succeeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("pusherUser on Subscription Error: $message Exception: $e");
  }

  saveFile() async {
    if (file.isNotEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = file;
      final path = '${dir.path}/${file.split("/").last}';
      final bytes = await File(filePath).readAsBytes();
      await File(path).writeAsBytes(bytes);
    }
  }

  @override
  void onInit() async {
    id = Get.arguments['id'];
    recID = Get.arguments['recID'];
    user = Get.arguments['user'];
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingMessagesPagination) {
          await fetchMessage(isPaginate: true);
        }
      }
    });
    messageController.addListener(() {
      isFiledNotEmpty = messageController.text.isNotEmpty;
    });
    record.onStateChanged().listen((event) {
      isRecord = event == RecordState.record;
    });
    await fetchMessage();
    await initPusher();
    markAllAsRead();
    super.onInit();
  }

  @override
  void onClose() {
    record.dispose();
    markAllAsRead();
    cancelTimer();
    pusherUser?.unsubscribe(channelName: pusherChannelName);
    pusherUser?.disconnect();
    pusherUser = null;
    if (Get.isRegistered<IncomeController>()) {
      Get.find<IncomeController>().getMyConversation();
    }
    super.onClose();
  }
}
