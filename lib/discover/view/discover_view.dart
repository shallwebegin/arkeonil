import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/discover/controller/discover_controller.dart';
import 'package:arkeonil/features/widgets/appbar_with_title.dart';
import 'package:arkeonil/features/widgets/content_list_view.dart';
import 'package:arkeonil/features/widgets/subtitle_widget.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverView extends ConsumerWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarWithTitle(title: 'Discover'),
              Expanded(
                flex: 1,
                child: StreamBuilder<List<UserModel>>(
                  stream:
                      ref.watch(discoverControllerProvider).getProfilePhotos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserModel> user = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          final users = user[index];

                          return Padding(
                            padding: all15,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(users.profilePhoto!),
                                ),
                                Padding(
                                  padding: top10,
                                  child: Text(
                                    users.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                  },
                ),
              ),
              const SubTitleWidget(
                title: 'Most viewed articles',
              ),
              const Expanded(flex: 2, child: ContentListView()),
              const SubTitleWidget(
                title: 'Articles',
              ),
              const Expanded(
                flex: 2,
                child: ContentListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}