import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/features/auth/views/sign_in.dart';
import 'package:arkeonil/features/more/controller/more_controller.dart';
import 'package:arkeonil/features/widgets/appbar_with_title.dart';
import 'package:arkeonil/features/widgets/subtitle_widget.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:arkeonil/router/router_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreView extends ConsumerWidget {
  const MoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: ref.read(moreControllerProvider).getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userModel = snapshot.data!;
            return SafeArea(
              child: Padding(
                padding: scaffoldPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppbarWithTitle(title: 'More'),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              userModel.profilePhoto!),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: vertical10,
                      child: SubTitleWidget(title: 'Create content'),
                    ),
                    _MoreMenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AppRouteNames.writeArticle,
                            arguments: {'currentUser': userModel});
                      },
                      title: 'Write an article',
                      leadingSvg: articleSvg,
                    ),
                    _MoreMenuItem(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteNames.yourArticles);
                      },
                      title: 'Your articles',
                      leadingSvg: articleSvg,
                    ),
                    const SubTitleWidget(title: 'Profile'),
                    _MoreMenuItem(
                      onTap: () {},
                      title: 'Edit profile',
                      leadingSvg: editProfile,
                    ),
                    _MoreMenuItem(
                      onTap: () {
                        ref.read(moreControllerProvider).signOut().then(
                              (value) => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ),
                              ),
                            );
                      },
                      title: 'Sign out',
                      leadingSvg: signOutSvg,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.leadingSvg,
  });
  final void Function()? onTap;
  final String title;
  final String leadingSvg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: vertical5,
        child: Card(
            color: buttonColor,
            child: ListTile(
              leading: SvgPicture.asset(leadingSvg),
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: whiteColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: whiteColor,
              ),
            )),
      ),
    );
  }
}
