class AppInfoEntity {
  String androidVersion;
  String iosVersion;
  String androidUrl;
  String iosUrl;
  int activateRedeemGolds;
  String vip;

  AppInfoEntity({
    required this.activateRedeemGolds,
    required this.androidUrl,
    required this.androidVersion,
    required this.iosUrl,
    required this.iosVersion,
    required this.vip,
  });
}
