// Created by Muhamad Fauzi Ridwan on 24/08/21.

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/features/kalkulator/presentation/pages/_pages.dart';
import 'package:ulaskelas/services/_services.dart';
import 'package:ulaskelas/src/bar/_bar.dart';
import 'core/bases/states/_states.dart';
import 'features/home/presentation/pages/_pages.dart';
import 'features/leaderboard/presentation/pages/_pages.dart';
import 'features/matkul/search/presentation/pages/_pages.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/tanyateman/presentation/pages/_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseStateful<MainPage> {
  late int _selectedIndex;
  late List<Widget> _children;

  @override
  void init() {
    _children = <Widget>[
      HomePage(
        onSeeAllCourse: () {
          setState(() => _selectedIndex = 1);
          MixpanelService.track('view_all_courses');
        },
      ),
      const SearchCoursePage(),
      // const LeaderboardPage(),   this page has been shut down
      const TanyaTemanPage(),
      const CalculatorPage(),
      const ProfilePage(),
    ];
    _selectedIndex = 0;
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute(
      bottomNavigation: _convexNavigation(),
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: _children[_selectedIndex],
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(
      context,
      sizeInfo,
    );
  }

  Widget? _convexNavigation() {
    return NewRistekBotNavBar(
      initialActiveIndex: _selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 1:
            MixpanelService.track('open_courses');
          case 2:
            MixpanelService.track('open_askfriends');
          case 3:
            MixpanelService.track('open_calculator');
          case 4:
            MixpanelService.track('open_profile');
        }
        setState(() => _selectedIndex = index);
      },
      items: const [
        NewRistekBotNavItem(
          icon: Icons.home,
          text: 'Beranda',
        ),
        NewRistekBotNavItem(
          icon: Icons.list_alt,
          text: 'Matkul',
        ),
        // RistekBotNavItem(            this page has been shut down
        //   icon: Icons.leaderboard,      for ulaskelas revamp 
        //   text: 'Klasemen',               changed into tanya teman
        // ),
        NewRistekBotNavItem(
          svgIcon: 'assets/icons/tanyateman.svg',
          text: 'Tanya Teman',
        ),
        NewRistekBotNavItem(
          icon: Icons.calculate,
          text: 'Kalkulator',
        ),
        NewRistekBotNavItem(
          icon: Icons.account_circle,
          text: 'Profil',
        ),
      ],
    );
  }

  DateTime? preBackPress;

  @override
  Future<bool> onBackPressed() async {
    final timeGap = DateTime.now().difference(preBackPress ?? DateTime.now());
    final cantExit = timeGap >= const Duration(seconds: 2);
    preBackPress = DateTime.now();
    if (cantExit) {
      // show warning messenger.
      WarningMessenger('Press Back button again to Exit').show(ctx!);
      return false;
    } else {
      return true;
    }
  }
}
