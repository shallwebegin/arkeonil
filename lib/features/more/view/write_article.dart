import 'dart:io';

import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/common/repository/common_firebase_repository.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:arkeonil/common/utils.dart';
import 'package:arkeonil/features/more/controller/more_controller.dart';
import 'package:arkeonil/models/article_cities_model.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum CategoryLabel {
  egypt('Egypt'),
  greek('Greek'),
  earth('Earth'),
  turkey('Turkey');

  const CategoryLabel(
    this.label,
  );
  final String label;
}

enum CityLabel {
  egypt('Kahire'),
  egypt2('Sakkara'),

  greek('Athens'),
  turkey('Kesan'),
  greek2('Xanthi');

  const CityLabel(
    this.label,
  );
  final String label;
}

class WriteArticle extends ConsumerStatefulWidget {
  const WriteArticle({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  ConsumerState<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends ConsumerState<WriteArticle> {
  XFile? image;
  CategoryLabel? selectedCategory;
  CityLabel? selectedCity;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _cityController.dispose();
  }

  void pickImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: whiteColor,
            ),
          ),
          title: Text(
            'Your Article',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final user = widget.currentUser;

                  ref
                      .read(commonFirebaseRepository)
                      .storeFileToFirebase(
                        "articles/${user.uid}/${DateTime.now().millisecondsSinceEpoch}",
                        File(image!.path),
                      )
                      .then((value) {
                    String uid = const Uuid().v4();
                    ArticleModel articleModel = ArticleModel(
                      uid: uid,
                      title: _titleController.text,
                      content: _contentController.text,
                      author: "${user.name} ${user.surname}",
                      authorImg: user.profilePhoto!,
                      createdAt: DateTime.now(),
                      coverImg: value,
                      authorUid: user.uid!,
                      isFavorite: false,
                      category: _categoryController.text,
                      cityName: _cityController.text.split(','),
                    );

                    ref
                        .read(moreControllerProvider)
                        .writeArticles(articleModel)
                        .then((value) => Navigator.of(context).pop());
                  });
                }
              },
              icon: const Icon(
                Icons.done,
                color: whiteColor,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: scaffoldPadding,
            child: Column(
              children: [
                Padding(
                  padding: vertical10,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(20),
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(image!.path),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(addImageSvg),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: whiteColor),
                          controller: _titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill the title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: 'Your article title here !',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: greyColor),
                          ),
                        ),
                        TextFormField(
                          style: const TextStyle(color: whiteColor),
                          controller: _contentController,
                          maxLines: 100,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill the article';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: 'Your article content here !',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: greyColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      DropdownMenu<CategoryLabel>(
                        initialSelection: CategoryLabel.egypt,
                        controller: _categoryController,
                        requestFocusOnTap: true,
                        dropdownMenuEntries: CategoryLabel.values
                            .map<DropdownMenuEntry<CategoryLabel>>(
                                (CategoryLabel category) {
                          return DropdownMenuEntry<CategoryLabel>(
                            value: category,
                            label: category.label,
                            enabled: category.label != 'Heart',
                            style: MenuItemButton.styleFrom(
                              backgroundColor: whiteColor,
                              foregroundColor: buttonColor,
                            ),
                          );
                        }).toList(),
                        label: Text(
                          'Category',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: whiteColor),
                        ),
                        onSelected: (CategoryLabel? category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                      DropdownMenu<CityLabel>(
                        initialSelection: CityLabel.egypt,
                        controller: _cityController,
                        requestFocusOnTap: true,
                        dropdownMenuEntries: CityLabel.values
                            .map<DropdownMenuEntry<CityLabel>>(
                                (CityLabel city) {
                          return DropdownMenuEntry<CityLabel>(
                            value: city,
                            label: city.label,
                            enabled: city.label != 'Kesan',
                            style: MenuItemButton.styleFrom(
                              backgroundColor: whiteColor,
                              foregroundColor: buttonColor,
                            ),
                          );
                        }).toList(),
                        label: Text(
                          'Cities',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: whiteColor),
                        ),
                        onSelected: (CityLabel? city) {
                          setState(() {
                            selectedCity = city;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
