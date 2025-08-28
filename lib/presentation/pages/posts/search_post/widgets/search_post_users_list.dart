import 'package:flutter/material.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/presentation/pages/posts/search_post/widgets/search_post_user_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class SearchPostUsersList extends StatelessWidget {
  final List<UserEntity> users;
  const SearchPostUsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyDataWidget(),
      );
    } else {
      return SliverList.separated(
        itemBuilder: (context, index) {
          return SearchPostUserItem(
            user: users[index],
            isVisitor: true,
          );
        },
        separatorBuilder: (context, index) => 10.verticalSpace(),
        itemCount: users.length,
      );
    }
  }
}
