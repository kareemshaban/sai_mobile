import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/data/params/room_params/room_user_params.dart';

class EndPoint {
  static const String baseUrl = "https://arabchatapp.com/api";
  static const String baseShareUrl = "https://arabchatapp.com/share";
  static const String login = "/user/v1/login";
  static const String registerVerification = "/user/v1/register-verification";
  static const String verifyCode = "/user/v1/verify-code";
  static const String register = "/user/v1/register";
  static const String forgetPassword = "/user/v1/forget-password";
  static const String verifyForgetPassword = "/user/v1/verify-forget-password";
  static const String resetPassword = "/user/v1/reset-password";
  static const String countryList = "/countries-list";
  static const String updateProfile = "/user/update-profile";
  static const String myProfile = "/user/my-profile";
  static const String home = "/market/home";
  static const String myAddresses = "/market/address/my";
  static String addRemoveProductToFavorite(int params) =>
      "/market/favorite/product/$params";
  static const String getMyFavorite = "/market/favorite/products";
  static const String addAddress = "/market/address/add";
  static String updateAddress(int id) => "/market/address/update/$id";
  static String deleteAddress(int id) => "/market/address/delete/$id";
  static const String myRoom = "/user/my-room";
  static const String popularRooms = "/popular-rooms";
  static const String famousRooms = "/famous-rooms";
  static const String memperRooms = "/user/member-rooms";
  static const String orders = "/market/order/all";
  static const String globalStatistics = "/global-statistics";
  static String roomGiftUsers(int id) => "/user/list_room_gifts/$id";
  static const String logout = "/user/logout";
  static const String roomBanners = "/top-three-statistics";
  static const String createRoom = "/user/create-room";
  static String joinRoom(String params) => "/join-room/$params";
  static String leaveRoom(String params) => "/leave-room/$params";
  static const String generateZegoToken = "/zego/generate-token";
  static String getUserProfileByID(int params) => "/user/user-profile/$params";
  static const String giftList = "/gifts-list";
  static String roomSettings(String params) => "/user/settings/$params";
  static String updateRoomSettings(String params) =>
      "/user/update-settings/$params";
  static String sendRoomMessage(String params) =>
      "/user/send-event-message/$params";
  static String lockMic(String params) => "/user/lock-mic/$params";
  static String unlockMic(String params) => "/user/unlock-mic/$params";
  static String lockRoom(String params) => "/user/set-room-lock/$params";
  static String unlockRoom(String params) => "/user/remove-lock/$params";
  static String getRoomMempers(String params) => "/user/members/$params";
  static String fireUser(String params) => "/user/fier-user/$params";
  static String cancelFireUser(String params) =>
      "/user/cancel-fier-user/$params";
  static String getFireUserList(String params) => "/user/fiered-list/$params";
  static String getRoomUser(RoomUserParams params) =>
      "/user-chat-profile/${params.roomID}/${params.userID}";
  static const String updateUserRole = "/user/update-role";
  static String joinAsMember(String params) => "/user/member-fees/$params";
  static const String cancelMembership = "/user/cancel-membership";
  static const String roomReport = "/user/add-report";
  static const String usersList = "/users-list";
  static const String sendFriendRequest = "/user/friend-request";
  static String cancelFriendRequest(int params) =>
      "/user/remove-friend/$params";
  static String sendRoomGift(String params) => "/user/send-event-gift/$params";
  static String getProductDetails(int params) => "/market/products/$params";
  static const String applyCoupon = "/market/order/apply/coupon";
  static const String addOrder = "/market/order/add";
  static String searchProduct(int params) => "/market/products?page=$params";
  static const String productFilter = "/market/filters-products";
  static String getDeliveryPrice(int params) =>
      "/market/order/delivery_price/$params";
  static const String roomByCountry = "/discovery-page-filter";
  static String getOrderDetails(int params) => "/market/order/$params";
  static String cancelOrder(int params) => "/market/order/cancel/$params";
  static const String myConversation = "/user/my-conversations";
  static String fetchMessages(FetchMessagesParams params) =>
      "/user/fetch-message/${params.chatID}?page=${params.page}";
  static String markAllAsRead(FetchMessagesParams params) =>
      "/user/mark-read/${params.chatID}/${params.recID}";
  static const String sendMessage = "/user/send-message";
  static String deliveredMessage(int params) =>
      "/user/delivered-message/$params";
  static const String friendRequest = "/user/friend-requests-list";
  static String acceptFriend(int params) => "/user/accept-friend/$params";
  static String removeFriend(int params) => "/user/remove-friend/$params";
  static const String getNotification = "/user/all-notifications";
  static const String markAsRead = "/user/read-all-notification";
  static const String notificationCount = "/user/unread-count-notification";
  static const String deleteAllNotification = "/user/delete-all-notification";
  static const String premiumList = "/user/premium-list";
  static String activatePremium(int params) =>
      "/user/activation-premium/$params";
  static String renewPremium(int params) => "/user/renewal-premium/$params";
  static const String settingMarket = "/user/market-home";
  static String settingMarketProduct(int params) => "/user/products/$params";
  static const String buySettings = "/user/buy-product";
  static String selectSettingProduct(int params) =>
      "/user/select-product/$params";
  static String termsPrivacy(int params) => "/page/$params";
  static const String deleteAccount = "/user/delete-account";
  static String deleteChat(int params) => "/user/delete-conversation/$params";
  static String updateLang(String lang) => "/user/change_lang/$lang";
  static const String changePassword = "/user/update_password";
  static const String changeEmail = "/user/update_email";
  static const String changePhone = "/user/update_phone";
  static const String sendCodeToEmail = "/user/send_code_to_edit_email";
  static const String sendCodeToPhone = "/user/send_code_to_edit_phone";
  static const String giftRecord = "/user/my_gift_record";
  static const String bounceRecord = "/user/my_bounce_record";
  static const String allFriends = "/user/all-friends";
  static const String myVisitor = "/user/my-visitors";
  static String getUsersType(String type) => "/user/followers_type?type=$type";
  static const String redeemsRecord = "/user/my_redeems_record";
  static const String redeemRequest = "/user/redeem-request";
  static const String report = "/user/complaint/send";
  static const String changePrivacy = "/user/privacy/change";
  static const String updateFcmToken = "/user/update-fcm";
  static const String appInfo = "/get-info";
  static String appSearch(AppSearchParams params) =>
      "/user/reels/filter/${params.filter}/${params.search}";

  //? Stories
  static const String _stories = "/user/stories";
  static const String addStory = "$_stories/store";
  static String userStories(int params) => "/user/$params/stories";
  static String storyComment(int params) => "$_stories/get_comments/$params";
  static String storyViews(int params) => "$_stories/get_views/$params";
  static String addComment(int params) => "$_stories/add_comment/$params";
  static String showStory(int params) => "$_stories/show/$params";
  static String storyByID(int params) => "$_stories/show_story/$params";
  static String deleteStory(int params) => "$_stories/delete_file/$params";

  //? reels
  static const String reels = "/user/reels";
  static String reelsComment(int params) => "/user/reels/get_comments/$params";
  static String reelsAddComment(int params) =>
      "/user/reels/add_comment/$params";
  static String likeReel(int params) => "/user/reels/like/$params";
  static String saveReel(int params) => "/user/reels/save/$params";
  static const String savedReels = "/user/reels/archive";
  static String userReels(int params) => "/user/$params/reels";
  static const String postReels = "/user/reels/store";
  static String showReels(int params) => "/user/reels/show/$params";
  static String deleteReels(int params) => "/user/reels/delete/$params";
  static String shareReels(int params) => "/user/reels/share/$params";
  //? wallet

  static const String _user = "/user";
  static const String shippingUnits = "$_user/shipping-units";
}
