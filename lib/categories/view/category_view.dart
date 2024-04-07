import 'package:arkeonil/categories/controller/categories_controller.dart';
import 'package:arkeonil/categories/view/category_cities_view.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/features/widgets/more_menu_item.dart';
import 'package:arkeonil/models/archae_category_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryView extends ConsumerWidget {
  const CategoryView({
    required this.model,
    super.key,
  });
  final ArchaeCategory model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            model.category,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: whiteColor),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: scaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: StreamBuilder<List<ArchaeCategory>>(
                    stream: ref
                        .watch(categoryControllerProvider)
                        .getCitiesName(model.category, model.cityName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ArchaeCategory> cities = snapshot.data!;
                        return ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            final city = cities[index];
                            return Column(
                              children: [
                                ...city.cityName.map((name) => MoreMenuItem(
                                      onTap: () {
                                        List<String> selectedCity = [name];
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryCitiesView(
                                              model: model,
                                              selectedCity: selectedCity,
                                            ),
                                          ),
                                        );
                                      },
                                      title: name,
                                      leadingSvg: articleSvg,
                                    )),
                              ],
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
              ],
            ),
          ),
        ));
  }
}
