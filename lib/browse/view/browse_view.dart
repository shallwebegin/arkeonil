import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/features/widgets/appbar_with_title.dart';
import 'package:arkeonil/features/widgets/content_list_view.dart';
import 'package:arkeonil/features/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarWithTitle(title: 'Browse'),
              SubTitleWidget(title: 'Daily Articles'),
              Expanded(
                flex: 3,
                child: ContentListView(),
              ),
              SubTitleWidget(title: 'Mythology'),
              Expanded(
                flex: 3,
                child: ContentListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
