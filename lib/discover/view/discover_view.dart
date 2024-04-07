import 'package:arkeonil/categories/view/category_view.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/constants/string_constants.dart';
import 'package:arkeonil/discover/controller/discover_controller.dart';
import 'package:arkeonil/features/widgets/appbar_with_title.dart';
import 'package:arkeonil/features/widgets/content_list_view.dart';
import 'package:arkeonil/features/widgets/subtitle_widget.dart';
import 'package:arkeonil/models/archae_category_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({
    super.key,
  });

  @override
  ConsumerState<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarWithTitle(title: StringConstants.discover),
              Expanded(
                flex: 1,
                child: StreamBuilder<List<ArchaeCategory>>(
                  stream:
                      ref.watch(discoverControllerProvider).getProfilePhotos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ArchaeCategory> article = snapshot.data!;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: article.length,
                        itemBuilder: (context, index) {
                          final articles = article[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryView(model: articles),
                                ),
                              );
                            },
                            child: Padding(
                              padding: all16,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(articles.image),
                                  ),
                                  Padding(
                                    padding: top10,
                                    child: Text(
                                      articles.category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: whiteColor),
                                    ),
                                  ),
                                ],
                              ),
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
                title: StringConstants.mostViewedArticles,
              ),
              const Expanded(flex: 2, child: ContentListView()),
              const SubTitleWidget(
                title: StringConstants.articles,
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
