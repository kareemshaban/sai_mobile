import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PullToRefreshWidget extends StatelessWidget {
  final RefreshController controller;
  final ScrollController scrollController;
  final void Function()? onRefresh;
  final Widget child;
  const PullToRefreshWidget({
    super.key,
    required this.controller,
    this.onRefresh,
    required this.child,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      onRefresh: onRefresh,
      enablePullUp: false,
      enablePullDown: true,
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const SizedBox();
          } else if (mode == LoadStatus.loading) {
            body = const SizedBox();
          } else if (mode == LoadStatus.failed) {
            body = const SizedBox();
          } else if (mode == LoadStatus.canLoading) {
            body = const CupertinoActivityIndicator();
          } else {
            body = const SizedBox();
          }
          return Center(child: body);
        },
      ),
      scrollController: scrollController,
      child: child,
    );
  }
}
