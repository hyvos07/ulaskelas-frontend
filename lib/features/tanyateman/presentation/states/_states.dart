import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/features/matkul/search/data/models/_models.dart';

import '../../data/datasources/_datasources.dart';
import '../../data/models/_models.dart';
import '../../data/repositories/_repositories.dart';
import '../../domain/entities/query_question.dart';
import '../../domain/repositories/_repositories.dart';

part 'answer_state.dart';
part 'question_form_state.dart';
part 'question_state.dart';
