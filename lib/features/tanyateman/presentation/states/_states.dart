import 'dart:collection';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/core/error/_error.dart';
import 'package:ulaskelas/features/matkul/main/data/datasources/_datasources.dart';
import 'package:ulaskelas/features/matkul/main/data/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/main/domain/entities/query_search_course.dart';
import 'package:ulaskelas/features/matkul/main/domain/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/search/data/models/_models.dart';
import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

import '../../data/datasources/_datasources.dart';
import '../../data/models/_models.dart';
import '../../data/repositories/_repositories.dart';
import '../../domain/entities/query_question.dart';
import '../../domain/repositories/_repositories.dart';

part 'question_state.dart';
part 'answer_state.dart';
part 'question_form_state.dart';
