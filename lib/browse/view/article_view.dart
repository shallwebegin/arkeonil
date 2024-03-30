import 'package:arkeonil/browse/controller/browse_controller.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleView extends ConsumerStatefulWidget {
  const ArticleView({super.key, required this.article});
  final ArticleModel article;

  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  @override
  Widget build(BuildContext context) {
    void isFavorite() {
      setState(() {
        widget.article.isFavorite = !widget.article.isFavorite;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: Text(
          overflow: TextOverflow.ellipsis,
          widget.article.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: whiteColor),
        ),
        actions: [
          FutureBuilder<Stream<List<ArticleModel>>>(
              future: ref
                  .read(browseControllerProvider)
                  .setArticlesFavorites(widget.article.uid, true),
              builder: (context, snapshot) {
                return IconButton(
                  onPressed: isFavorite,
                  icon: CircleAvatar(
                    backgroundColor: buttonColor,
                    child: SvgPicture.asset(
                      bookmarkSvg,
                      colorFilter:
                          const ColorFilter.mode(whiteColor, BlendMode.srcIn),
                    ),
                  ),
                );
              }),
        ],
      ),
      body: Padding(
        padding: scaffoldPadding,
        child: Column(
          children: [
            Padding(
              padding: vertical20,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(widget.article.coverImg!),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.article.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: whiteColor),
                    ),
                  ),
                  Padding(
                    padding: vertical10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.article.content,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
