import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:ulaskelas/core/extension/_extension.dart';

import '../../../../core/client/_client.dart';
import '../../../../core/environment/_environment.dart';
import '../../domain/entities/query_answer.dart';
import '../../domain/entities/query_question.dart';
import '../models/_models.dart';

part 'question_remote_data_source.dart';
part 'answer_remote_data_source.dart';
