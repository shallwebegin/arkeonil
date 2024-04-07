import 'package:arkeonil/bookmark/view/bookmark_view.dart';
import 'package:arkeonil/browse/view/browse_view.dart';
import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/paths.dart';
import 'package:arkeonil/constants/string_constants.dart';
import 'package:arkeonil/discover/view/discover_view.dart';
import 'package:arkeonil/features/more/view/more_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> list = const [
    DiscoverView(),
    BrowseView(),
    BookmarkView(),
    MoreView(),
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(color: buttonColor),
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(homeDeActiveSvg),
              activeIcon: SvgPicture.asset(homeActiveSvg),
              label: StringConstants.discover),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(browseDeActiveSvg),
              activeIcon: SvgPicture.asset(browseActiveSvg),
              label: StringConstants.browse),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(bookmarkDeActiveSvg),
              activeIcon: SvgPicture.asset(bookmarkActiveSvg),
              label: StringConstants.bookmark),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(userDeActiveSvg),
              activeIcon: SvgPicture.asset(userActiveSvg),
              label: StringConstants.more),
        ],
      ),
    );
  }
}
