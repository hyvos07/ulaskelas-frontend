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

  // Tanya Teman Page
  final GlobalKey _searchBarTT = GlobalKey();
  final GlobalKey _userBoxTT = GlobalKey();

  // Calculator Page
  final GlobalKey _emptySemesterGC = GlobalKey();
  final GlobalKey _autoFillGC = GlobalKey();
  final GlobalKey _filledSemesterGC = GlobalKey();
  final GlobalKey _semesterCardGC = GlobalKey();
  final GlobalKey _courseCardGC = GlobalKey();

  // Course Calculator Page
  final GlobalKey _totalComponentGC = GlobalKey();
  final GlobalKey _addComponentGC = GlobalKey();
  final GlobalKey _incompleteComponentGC = GlobalKey();
  final GlobalKey _targetScoreGC = GlobalKey();
  final GlobalKey _finalScoreGC = GlobalKey();

  // Add Component Page
  final GlobalKey _componentFieldGC = GlobalKey();
  final GlobalKey _componentNameGC = GlobalKey();
  final GlobalKey _componentWeightGC = GlobalKey();
  final GlobalKey _componentScoreGC = GlobalKey();

  /////////////
  // Getters //
  /////////////

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
  GlobalKey get searchBarTT => _searchBarTT;
  GlobalKey get userBoxTT => _userBoxTT;
  GlobalKey get emptySemesterGC => _emptySemesterGC;
  GlobalKey get autoFillGC => _autoFillGC;
  GlobalKey get filledSemesterGC => _filledSemesterGC;
  GlobalKey get semesterCardGC => _semesterCardGC;
  GlobalKey get courseCardGC => _courseCardGC;
  GlobalKey get totalComponentGC => _totalComponentGC;
  GlobalKey get addComponentGC => _addComponentGC;
  GlobalKey get incompleteComponentGC => _incompleteComponentGC;
  GlobalKey get targetScoreGC => _targetScoreGC;
  GlobalKey get finalScoreGC => _finalScoreGC;
  GlobalKey get componentFieldGC => _componentFieldGC;
  GlobalKey get componentNameGC => _componentNameGC;
  GlobalKey get componentWeightGC => _componentWeightGC;
  GlobalKey get componentScoreGC => _componentScoreGC;
}
