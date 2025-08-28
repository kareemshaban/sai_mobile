import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/getx/add_new_address_binding.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/view/add_new_address_view.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_binding.dart';
import 'package:new_sai/presentation/pages/address_pages/address/view/address_view.dart';
import 'package:new_sai/presentation/pages/auth/create_password/getx/create_password_binding.dart';
import 'package:new_sai/presentation/pages/auth/create_password/view/create_password_view.dart';
import 'package:new_sai/presentation/pages/auth/forget_password/getx/forget_password_binding.dart';
import 'package:new_sai/presentation/pages/auth/forget_password/view/forget_password_view.dart';
import 'package:new_sai/presentation/pages/auth/login_register/controller/login_register_binding.dart';
import 'package:new_sai/presentation/pages/auth/login_register/view/login_register_view.dart';
import 'package:new_sai/presentation/pages/auth/otp/getx/otp_binding.dart';
import 'package:new_sai/presentation/pages/auth/otp/view/otp_view.dart';
import 'package:new_sai/presentation/pages/auth/profile_data/getx/profile_data_binding.dart';
import 'package:new_sai/presentation/pages/auth/profile_data/view/profile_data_view.dart';
import 'package:new_sai/presentation/pages/auth/reset_password/getx/reset_password_binding.dart';
import 'package:new_sai/presentation/pages/auth/reset_password/view/reset_password_view.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_binding.dart';
import 'package:new_sai/presentation/pages/camera/view/camera_view.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_binding.dart';
import 'package:new_sai/presentation/pages/gallery/view/gallery_view.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/getx/chat_binding.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/view/chat_view.dart';
import 'package:new_sai/presentation/pages/income_pages/friend_requests/getx/friend_requests_binding.dart';
import 'package:new_sai/presentation/pages/income_pages/friend_requests/view/friend_requests_view.dart';
import 'package:new_sai/presentation/pages/main/getx/main_binding.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_binding.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_binding.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_binding.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_binding.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_binding.dart';
import 'package:new_sai/presentation/pages/main/view/main_view.dart';
import 'package:new_sai/presentation/pages/notifications/getx/notifications_binding.dart';
import 'package:new_sai/presentation/pages/notifications/view/notifications_view.dart';
import 'package:new_sai/presentation/pages/posts/post_settings/getx/post_settings_binding.dart';
import 'package:new_sai/presentation/pages/posts/post_settings/view/post_settings_view.dart';
import 'package:new_sai/presentation/pages/posts/post_view/getx/post_view_binding.dart';
import 'package:new_sai/presentation/pages/posts/post_view/view/post_view.dart';
import 'package:new_sai/presentation/pages/posts/search_post/getx/search_post_binding.dart';
import 'package:new_sai/presentation/pages/posts/search_post/view/search_post_view.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/view/cart_view.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/view/category_search_view.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/view/confirm_order_view.dart';
import 'package:new_sai/presentation/pages/product_pages/favorite/getx/favorite_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/favorite/view/favorite_view.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/view/order_details_view.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/getx/orders_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/view/orders_view.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/view/product_details_view.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/getx/product_search_binding.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/view/product_search_view.dart';
import 'package:new_sai/presentation/pages/room_pages/country_room/getx/country_room_binding.dart';
import 'package:new_sai/presentation/pages/room_pages/country_room/view/country_room_view.dart';
import 'package:new_sai/presentation/pages/room_pages/create_room/getx/create_room_binding.dart';
import 'package:new_sai/presentation/pages/room_pages/create_room/view/create_room_view.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_binding.dart';
import 'package:new_sai/presentation/pages/room_pages/room/view/room_view.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/getx/room_settings_binding.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/view/room_settings_view.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_binding.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/view/top_room_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/getx/settings_and_privacy_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account/getx/account_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account/view/account_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account_information/getx/account_information_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account_information/view/account_information_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_email/getx/change_email_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_email/view/change_email_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_mobile_number/getx/change_mobile_number_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_mobile_number/view/change_mobile_number_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_password/getx/change_password_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_password/view/change_password_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/country_list/getx/country_list_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/country_list/view/country_list_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/delete_my_account/getx/delete_my_account_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/delete_my_account/view/delete_my_account_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/getx/edit_profile_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/view/edit_profile_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/language/getx/language_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/language/view/language_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/getx/privacy_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/view/privacy_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/getx/report_a_problem_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/view/report_a_problem_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/settings_market/getx/settings_market_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/settings_market/view/settings_market_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/terms_privacy/getx/terms_preivacy_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/terms_privacy/view/terms_privacy_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/view/unique_personal_id_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_binding.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/view/vip_view.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/view/settings_and_privacy_view.dart';
import 'package:new_sai/presentation/pages/splash/getx/splash_binding.dart';
import 'package:new_sai/presentation/pages/splash/view/splash_view.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_binding.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/view/my_stories_comment_and_views_view.dart';
import 'package:new_sai/presentation/pages/story_pages/my_story/getx/my_story_binding.dart';
import 'package:new_sai/presentation/pages/story_pages/my_story/view/my_story_view.dart';
import 'package:new_sai/presentation/pages/story_pages/story_view/getx/story_view_binding.dart';
import 'package:new_sai/presentation/pages/story_pages/story_view/view/story_view.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_binding.dart';
import 'package:new_sai/presentation/pages/user_profile/view/user_profile_view.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/getx/users_and_saved_reels_binding.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/view/users_and_saved_reels_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_bank_account/getx/add_bank_account_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_bank_account/view/add_bank_account_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_paypal_account/getx/add_paypal_account_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/add_paypal_account/view/add_paypal_account_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/view/cash_withdrawal_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/getx/charge_wallet_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/view/charge_wallet_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/payment_method/getx/payment_method_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/payment_method/view/payment_method_view.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_binding.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/view/wallet_view.dart';
import 'package:x_overlay/x_overlay.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String loginRegisterRoute = '/loginRegisterRoute';
  static const String otpRoute = '/otpRoute';
  static const String createPasswordRoute = '/createPasswordRoute';
  static const String profileDataRoute = '/profileDataRoute';
  static const String mainRoute = '/mainRoute';
  static const String cartRoute = '/cartRoute';
  static const String addressRoute = '/addressRoute';
  static const String addNewAddressRoute = '/addNewAddressRoute';
  static const String favoriteRoute = '/favoriteRoute';
  static const String ordersRoute = '/ordersRoute';
  static const String productSearchRoute = '/productSearchRoute';
  static const String createRoomRoute = '/createRoomRoute';
  static const String roomRoute = '/roomRoute';
  static const String roomSettingsRoute = '/roomSettingsRoute';
  static const String editProfileRoute = '/editProfileRoute';
  static const String settingsAndPrivacyRoute = '/settingsAndPrivacyRoute';
  static const String accountRoute = '/accountRoute';
  static const String accountInformationRoute = '/accountInformationRoute';
  static const String changeMobileNumberRoute = '/changeMobileNumberRoute';
  static const String privacyRoute = '/privacyRoute';
  static const String changePasswordRoute = '/changePasswordRoute';
  static const String changeEmailRoute = '/changeEmailRoute';
  static const String deleteMyAccountRoute = '/deleteMyAccountRoute';
  static const String reportAProblemRoute = '/reportAProblemRoute';
  static const String walletRoute = '/walletRoute';
  static const String cashWithdrawalRoute = '/cashWithdrawalRoute';
  static const String paymentMethodRoute = '/paymentMethodRoute';
  static const String addBankAccountRoute = '/addBankAccountRoute';
  static const String addPaypalAccountRoute = '/addPaypalAccountRoute';
  static const String storyViewRoute = '/storyViewRoute';
  static const String myStoryRoute = '/myStoryRoute';
  static const String myStoriesCommentAndViewsRoute =
      '/myStoriesCommentAndViewsRoute';
  static const String cameraRoute = "/cameraRoute";
  static const String galleryRoute = "/galleryRoute";
  static const String postViewRoute = "/postViewRoute";
  static const String postSettingsRoute = "/postSettingsRoute";
  static const String searchPostRoute = "/searchPostRoute";
  static const String forgetPasswordRoute = "/forgetPasswordRoute";
  static const String resetPasswordRoute = "/resetPasswordRoute";
  static const String countryListRoute = "/countryListRoute";
  static const String userProfileRoute = "/userProfileRoute";
  static const String productDetailsRoute = "/productDetailsRoute";
  static const String confirmOrderRoute = "/confirmOrderRoute";
  static const String categorySearchRoute = "/categorySearchRoute";
  static const String uniquePersonalIDRoute = "/uniquePersonalIDRoute";
  static const String vipRoute = "/vipRoute";
  static const String countryRoomRoute = "/countryRoomRoute";
  static const String termsPrivacyRoute = "/termsPrivacyRoute";
  static const String friendRequestsRoute = "/friendRequestsRoute";
  static const String notificationsRoute = "/notificationsRoute";
  static const String chatRoute = "/chatRoute";
  static const String orderDetailsRoute = "/orderDetailsRoute";
  static const String topRoomsRoute = "/topRoomsRoute";
  static const String settingsMarketRoute = "/settingsMarketRoute";
  static const String usersAndSavedReelsRoute = "/usersAndSavedReelsRoute";
  static const String chargeWalletRoute = '/chargeWalletRoute';
  static const String languageRoute = '/languageRoute';

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final overlayController = XOverlayController();

  static final pages = <GetPage>[
    GetPage(
      name: splashRoute,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: loginRegisterRoute,
      page: () => const LoginRegisterView(),
      binding: LoginRegisterBinding(),
    ),
    GetPage(
      name: otpRoute,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: createPasswordRoute,
      page: () => const CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: profileDataRoute,
      page: () => const ProfileDataView(),
      binding: ProfileDataBinding(),
    ),
    GetPage(
      name: mainRoute,
      page: () => const MainView(),
      binding: MainBinding(),
      bindings: [
        StoreBinding(),
        RoomsBinding(),
        ReelsBinding(),
        IncomeBinding(),
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: cartRoute,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: addressRoute,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: addNewAddressRoute,
      page: () => const AddNewAddressView(),
      binding: AddNewAddressBinding(),
    ),
    GetPage(
      name: favoriteRoute,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: ordersRoute,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: productSearchRoute,
      page: () => const ProductSearchView(),
      binding: ProductSearchBinding(),
    ),
    GetPage(
      name: createRoomRoute,
      page: () => const CreateRoomView(),
      binding: CreateRoomBinding(),
    ),
    GetPage(
      name: roomRoute,
      page: () => const RoomView(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: roomSettingsRoute,
      page: () => const RoomSettingsView(),
      binding: RoomSettingsBinding(),
    ),
    GetPage(
      name: editProfileRoute,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: settingsAndPrivacyRoute,
      page: () => const SettingsAndPrivacyView(),
      binding: SettingsAndPrivacyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: accountRoute,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: accountInformationRoute,
      page: () => const AccountInformationView(),
      binding: AccountInformationBinding(),
    ),
    GetPage(
      name: changeMobileNumberRoute,
      page: () => const ChangeMobileNumberView(),
      binding: ChangeMobileNumberBinding(),
    ),
    GetPage(
      name: privacyRoute,
      page: () => const PrivacyView(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: changePasswordRoute,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: changeEmailRoute,
      page: () => const ChangeEmailView(),
      binding: ChangeEmailBinding(),
    ),
    GetPage(
      name: deleteMyAccountRoute,
      page: () => const DeleteMyAccountView(),
      binding: DeleteMyAccountBinding(),
    ),
    GetPage(
      name: reportAProblemRoute,
      page: () => const ReportAProblemView(),
      binding: ReportAProblemBinding(),
    ),
    GetPage(
      name: walletRoute,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: cashWithdrawalRoute,
      page: () => const CashWithdrawalView(),
      binding: CashWithdrawalBinding(),
    ),
    GetPage(
      name: paymentMethodRoute,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: addBankAccountRoute,
      page: () => const AddBankAccountView(),
      binding: AddBankAccountBinding(),
    ),
    GetPage(
      name: addPaypalAccountRoute,
      page: () => const AddPaypalAccountView(),
      binding: AddPaypalAccountBinding(),
    ),
    GetPage(
      name: storyViewRoute,
      page: () => const StoryView(),
      binding: StoryViewBinding(),
    ),
    GetPage(
      name: myStoryRoute,
      page: () => const MyStoryView(),
      binding: MyStoryBinding(),
    ),
    GetPage(
      name: myStoriesCommentAndViewsRoute,
      page: () => const MyStoriesCommentAndViewsView(),
      binding: MyStoriesCommentAndViewsBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: cameraRoute,
      page: () => const CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: galleryRoute,
      page: () => const GalleryView(),
      binding: GalleryBinding(),
    ),
    GetPage(
      name: postViewRoute,
      page: () => const PostView(),
      binding: PostViewBinding(),
    ),
    GetPage(
      name: postSettingsRoute,
      page: () => const PostSettingsView(),
      binding: PostSettingsBinding(),
    ),
    GetPage(
      name: searchPostRoute,
      page: () => const SearchPostView(),
      binding: SearchPostBinding(),
    ),
    GetPage(
      name: forgetPasswordRoute,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: resetPasswordRoute,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: countryListRoute,
      page: () => const CountryListView(),
      binding: CountryListBinding(),
    ),
    GetPage(
      name: userProfileRoute,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: productDetailsRoute,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: confirmOrderRoute,
      page: () => const ConfirmOrderView(),
      binding: ConfirmOrderBinding(),
    ),
    GetPage(
      name: categorySearchRoute,
      page: () => const CategorySearchView(),
      binding: CategorySearchBinding(),
    ),
    GetPage(
      name: uniquePersonalIDRoute,
      page: () => const UniquePersonalIdView(),
      binding: UniquePersonalIdBinding(),
    ),
    GetPage(
      name: vipRoute,
      page: () => const VipView(),
      binding: VipBinding(),
    ),
    GetPage(
      name: countryRoomRoute,
      page: () => const CountryRoomView(),
      binding: CountryRoomBinding(),
    ),
    GetPage(
      name: termsPrivacyRoute,
      page: () => const TermsPrivacyView(),
      binding: TermsPreivacyBinding(),
    ),
    GetPage(
      name: friendRequestsRoute,
      page: () => const FriendRequestsView(),
      binding: FriendRequestsBinding(),
    ),
    GetPage(
      name: notificationsRoute,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: chatRoute,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: orderDetailsRoute,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: topRoomsRoute,
      page: () => const TopRoomView(),
      binding: TopRoomsBinding(),
    ),
    GetPage(
      name: settingsMarketRoute,
      page: () => const SettingsMarketView(),
      binding: SettingsMarketBinding(),
    ),
    GetPage(
      name: usersAndSavedReelsRoute,
      page: () => const UsersAndSavedReelsView(),
      binding: UsersAndSavedReelsBinding(),
    ),
    GetPage(
      name: chargeWalletRoute,
      page: () => const ChargeWalletView(),
      binding: ChargeWalletBinding(),
    ),
    GetPage(
      name: languageRoute,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
  ];
}
