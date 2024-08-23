import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/features/kalkulator/data/datasources/_datasources.dart';
import 'package:ulaskelas/features/kalkulator/data/models/calculator_model.dart';
import 'package:ulaskelas/features/kalkulator/data/models/component_model.dart';
import 'package:ulaskelas/features/kalkulator/data/repositories/_repositories.dart';
import 'package:ulaskelas/features/kalkulator/domain/entities/query_calculator.dart';
import 'package:ulaskelas/features/kalkulator/domain/entities/query_component.dart';
import 'package:ulaskelas/features/kalkulator/domain/repositories/_repositories.dart';

import '../../../../core/utils/in_app_tour/showcase_flow.dart';
import '../../../../core/utils/in_app_tour/showcase_preview_data.dart';
import '../../../../core/utils/util.dart';
import '../../../../services/_services.dart';
import '../../../matkul/search/data/models/_models.dart';
import '../../data/models/semester_model.dart';
import '../../domain/entities/query_semester.dart';

part 'calculator_state.dart';
part 'component_state.dart';
part 'component_form_state.dart';
part 'semester_state.dart';
