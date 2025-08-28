import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_sai/data/model/game_model/game_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';

class GamePageInRoom extends GetView<RoomController> {
  const GamePageInRoom({super.key});
  bool showGame(Game g, String userType) {
    if (g.id == 1077) {
      return true;
    } else {
      if (userType != 'guest' && userType != 'member') {
        return true;
      } else if (userType == 'member' && g.active == 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: [
          SizedBox(
            // height: Get.height * 0.2,
            child: Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.09,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isLoadingGams.value) {
                          return SizedBox(
                              width: Get.width,
                              height: 200,
                              child: const Center(child: AppLoader()));
                        }
                        final games = controller.gameResponse.value!.gameList;
                        return SizedBox(
                          width: Get.width,
                          height: controller.isInSettingsMode.value == false
                              ? 90
                              : Get.height,
                          child: controller.isInSettingsMode.value
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.gameItems.length,
                                  itemBuilder: (_, index) {
                                    final item = controller.gameItems[index];

                                    bool invisibleSwitch = item.game.id == 1077;
                                    return
                                        //Obx(() =>
                                        Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(item.game.icon),
                                            radius: 25,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item.game.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          invisibleSwitch
                                              ? Container()
                                              : Obx(
                                                  () => Switch(
                                                    value: item.isActive.value,
                                                    onChanged: (val) {
                                                      controller
                                                          .toggleGameStatus(
                                                              item, index, val);
                                                    },
                                                  ),
                                                )
                                        ],
                                      ),
                                    );
                                    //);
                                  },
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: games.map((game) {
                                            return !showGame(
                                                    game, controller.room.role)
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () {
                                                      // controller.currentGame.value =
                                                      //     game;
                                                      // controller.currentGame.refresh();
                                                      if (showGame(
                                                          game,
                                                          controller
                                                              .room.role)) {
                                                        //   Get.back();
                                                        controller.currentGame
                                                            .value = game;
                                                        controller.currentGame
                                                            .refresh();

                                                        controller.isPlayingGame
                                                            .value = true;
                                                        //
                                                        // Get.to(GamePage(
                                                        //   gameUrl: game.url,
                                                        //   gameResponse:
                                                        //       controller.gameResponse.value!,
                                                        // ));
                                                      } else {
                                                        Get.showSnackbar(
                                                          GetSnackBar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            borderRadius: 16,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            isDismissible: true,
                                                            forwardAnimationCurve:
                                                                Curves
                                                                    .easeOutBack,
                                                            reverseAnimationCurve:
                                                                Curves
                                                                    .easeInBack,
                                                            messageText:
                                                                Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(16),
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .purple
                                                                        .withOpacity(
                                                                            0.9),
                                                                    Colors.blue
                                                                        .withOpacity(
                                                                            0.9)
                                                                  ],
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2),
                                                                    blurRadius:
                                                                        10,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            4),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .info_outline,
                                                                      color: Colors
                                                                          .white),
                                                                  const SizedBox(
                                                                      width:
                                                                          12),
                                                                  Expanded(
                                                                    child: Text(
                                                                      AppStrings
                                                                          .hintCantPaly,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  game.icon),
                                                          radius: 30,
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        Text(
                                                          game.name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          }).toList(),
                                        ),
                                      ),
                                      if (controller.room.role == 'admin' ||
                                          controller.room.role == 'owner')
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.isInSettingsMode
                                                  .toggle(); // تغيير الوضع
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.deepPurpleAccent,
                                                    Colors.blueAccent
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                    !controller.isInSettingsMode
                                                            .value
                                                        ? Icons.settings
                                                        : Icons.arrow_forward,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                        );
                      }),

                      Obx(() {
                        if (controller.gameResponse.value != null &&
                            controller.currentGame.value.id != 0 &&
                            controller.isInSettingsMode.value == false) {
                          return GamePage(
                            gameUrl: controller.currentGame.value.url,
                            gameResponse: controller.gameResponse.value!,
                          );
                        } else {
                          return Container();
                        }
                      }),
                      // if (controller.isPlayingGame.value)
                      //   GamePage(
                      //     gameUrl: controller.gameItems[0].game.url,
                      //     gameResponse: controller.gameResponse.value!,
                      //   )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: Get.height * 0.06, left: Get.width * 0.03),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () async {
                  if (controller.isInSettingsMode.value == true) {
                    controller.isInSettingsMode.value = false;
                    controller.isPlayingGame.value = true;
                  } else {
                    await controller.onGameClosed();
                    controller.isPlayingGame.value = false;
                  }
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final GameResponse gameResponse;
  final String gameUrl;

  const GamePage(
      {super.key, required this.gameResponse, required this.gameUrl});

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<GamePage> {
  late final WebViewController controller;
  final EventChannel eventChannelPlugin = const EventChannel('baishunChannel');
  final roomController = Get.find<RoomController>();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            //  currentUrl = await controller.currentUrl() ?? widget.gameUrl;

            if (url == 'about:blank') {
              // roomController.isPlayingGame.value = false;
              await roomController.onGameClosed();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(roomController.currentGame.value.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(
          true); // Set to false for release

      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    if (Platform.isAndroid) {
      eventChannelPlugin.receiveBroadcastStream().listen((event) {
        final obj = json.decode(event);
        String jsFunName = obj['jsCallback'];
        if (jsFunName.contains('getConfig')) {
          String jsUrl =
              "$jsFunName(${jsonEncode(widget.gameResponse.config.toJson())})";
          controller.runJavaScript(jsUrl);
        } else if (jsFunName.contains('destroy')) {
          controller.loadRequest(Uri.parse('about:blank'));
          dispose();
        } else if (jsFunName.contains('gameRecharge')) {
          // TODO: Implement payment mall logic
        } else if (jsFunName.contains('gameLoaded')) {
          // TODO: Handle game loaded
        }
      });
    } else {
      controller.addJavaScriptChannel("getConfig",
          onMessageReceived: (JavaScriptMessage jsonMessage) {
        final obj = json.decode(jsonMessage.message);
        String jsFunName = obj['jsCallback'];
        String jsUrl =
            jsFunName + "(${jsonEncode(widget.gameResponse.config.toJson())})";
        controller!.runJavaScript(jsUrl);
      });
      controller.addJavaScriptChannel("destroy",
          onMessageReceived: (JavaScriptMessage message) {
        controller.loadRequest(Uri.parse('about:blank'));
        super.dispose();
      });
      controller.addJavaScriptChannel("gameRecharge",
          onMessageReceived: (JavaScriptMessage message) {});
      controller.addJavaScriptChannel("gameLoaded",
          onMessageReceived: (JavaScriptMessage message) {});
    }
  }

  @override
  void didUpdateWidget(covariant GamePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.gameUrl != oldWidget.gameUrl) {
      controller.loadRequest(Uri.parse(widget.gameUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              AppStrings.exitGame,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppSize.s18(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              AppButton(
                title: AppStrings.yes,
                onTap: () {
                  roomController.isPlayingGame.value = false;
                  Navigator.of(context).pop(true); // Return true to allow pop
                },
              ),
              AppButton(
                title: AppStrings.no,
                backgroundColor: Colors.red,
                onTap: () {
                  Navigator.of(context)
                      .pop(false); // Return false to cancel pop
                },
              ),
            ],
          ),
        );
        return shouldExit;
      },
      child:
          // Scaffold(
          //   backgroundColor: Colors.transparent,
          //   body:
          Container(
        // padding: EdgeInsets.only(top: Get.height * 0.1),
        height: Get.height * 0.78,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //     height: double.infinity,
            //     width: double.infinity,
            //     child: Center(
            //         child: SizedBox(height: 50, width: 50, child: AppLoader()))),
            // Positioned.fill(
            //   child:
            Expanded(
              child: Container(
                  //   color: Colors.red,
                  // height: Get.height * 0.95,
                  child: WebViewWidget(controller: controller)),
            ),
            // SizedBox(
            //   height: Get.height * 0.05,
            // )
            //    ),
            // PositionedDirectional(
            //   start: 20,
            //   top: 40,
            //   child: GestureDetector(
            //     onTap: () => Get.dialog(AlertDialog(
            //       content: Text(
            //         AppStrings.exitGame,
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: AppSize.s18(context),
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       actions: [
            //         AppButton(
            //           title: AppStrings.yes,
            //           onTap: () {
            //             roomController.isPlayingGame.value = false;
            //             Get.back(); // Close dialog
            //             Get.back();
            //           },
            //         ),
            //         AppButton(
            //           title: AppStrings.no,
            //           backgroundColor: Colors.red,
            //           onTap: () {
            //             Get.back(); // Close dialog only
            //           },
            //         ),
            //       ],
            //     )),
            //     child: const CircleAvatar(
            //       child: Icon(Icons.arrow_back_outlined),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      //  ),
    );
  }

//   @override
//   void dispose() {
//     controller.loadRequest(Uri.parse('about:blank')); // This clears content
//     print("WebView disposed properly");
//     // super.dispose();
//   }
}
/*
 webview_flutter:
    path: packages/webview_flutter-4.9.0

dependency_overrides:
    webview_flutter_android:
      path: packages/webview_flutter_android-3.16.9
*/
