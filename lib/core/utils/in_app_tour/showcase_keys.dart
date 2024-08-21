import 'package:flutter/material.dart';

class InAppTourKeys {
  // Bottom Navigation Bar
  final GlobalKey _navbarMatkul = GlobalKey();
  final GlobalKey _navbarTanyaTeman = GlobalKey();
  final GlobalKey _navbarCalc = GlobalKey();
  final GlobalKey _navbarProfile = GlobalKey();

  // Search Page
  final GlobalKey _searchBarSP = GlobalKey();
  final GlobalKey _filterSP = GlobalKey();
  final GlobalKey _coursecardSP = GlobalKey();

  // Detail Matkul Page
  final GlobalKey _courseDetailDM = GlobalKey();
  final GlobalKey _reviewBySelfDM = GlobalKey();
  final GlobalKey _reviewsDM = GlobalKey();

  // Getters
  GlobalKey get navbarMatkul => _navbarMatkul;
  GlobalKey get navbarTanyaTeman => _navbarTanyaTeman;
  GlobalKey get navbarCalc => _navbarCalc;
  GlobalKey get navbarProfile => _navbarProfile;
  GlobalKey get searchBarSP => _searchBarSP;
  GlobalKey get filterSP => _filterSP;
  GlobalKey get coursecardSP => _coursecardSP;
  GlobalKey get courseDetailDM => _courseDetailDM;
  GlobalKey get reviewBySelfDM => _reviewBySelfDM;
  GlobalKey get reviewsDM => _reviewsDM;
}
