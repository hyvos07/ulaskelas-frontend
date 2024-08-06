import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:states_rebuilder/scr/state_management/listeners/on_reactive.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ulaskelas/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/bases/states/_states.dart';
import '../../../../core/constants/_constants.dart';
import '../../../../services/_services.dart';
import '../../../matkul/main/domain/entities/query_search_course.dart';
import '../../../matkul/search/data/models/_models.dart';
import '../../../matkul/search/presentation/states/_states.dart';
import '../../../matkul/search/presentation/widgets/_widgets.dart';
import '../../data/models/_models.dart';
import '../widgets/_widgets.dart';

part 'tanyateman_page.dart';
part 'forum_tanyateman_page.dart';
part 'add_question_page.dart';
part 'detail_question_page.dart';
part 'search_course_question.dart';
