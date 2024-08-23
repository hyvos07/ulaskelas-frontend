// Dummy data for showcase preview (will be not used after showcase finished)

import '../../../features/kalkulator/data/models/component_model.dart';

final Map<String, dynamic> dummyReview = {
  'id': 270,
  'user': 1022,
  'course': 3,
  'created_at': '2023-07-29T02:13:30.135920Z',
  'updated_at': '2023-07-29T02:39:56.480157Z',
  'academic_year': '2021/2022',
  'semester': 2,
  'content': 'Berguna banget soalnya di matkul ini belajar OOP '
      'yang bakal terus kepake kedepannya! Harus banget ngerti '
      'matkul yang satu ini sih...',
  'hate_speech_status': 'APPROVED',
  'sentimen': 0,
  'is_anonym': true,
  'is_active': true,
  'is_reviewed': false,
  'rating_understandable': 5.0,
  'rating_fit_to_credit': 5.0,
  'rating_fit_to_study_book': 5.0,
  'rating_beneficial': 5.0,
  'rating_recommended': 5.0,
  'author': 'someone',
  'author_generation': '2022',
  'author_study_program': 'Ilmu Komputer',
  'course_code': 'CSGE601021',
  'course_code_desc': 'Wajib Fakultas',
  'course_name': 'Dasar-Dasar Pemrograman 2',
  'course_review_count': 14,
  'tags': [],
  'likes_count': 0,
  'is_liked': false,
  'rating_average': 5.0
};

final Map<String, dynamic> dummyScoreComponent = {
  'data': {
    'score_component': [
      {
        'id': 1983,
        'calculator_id': 1433,
        'name': 'Tugas Individu',
        'weight': 20.0,
        'score': 80.0
      },
      {
        'id': 1984,
        'calculator_id': 1433,
        'name': 'UTS',
        'weight': 30.0,
        'score': 100.0
      },
      {
        'id': 1985,
        'calculator_id': 1433,
        'name': 'UAS',
        'weight': 40.0,
        'score': 90.0
      },
      {
        'id': 1986,
        'calculator_id': 1433,
        'name': 'Kuis',
        'weight': 10.0,
        'score': null,
      }
    ],
    'calculator': {
      'id': 1433,
      'user': 'daniel.liman',
      'course_id': 15,
      'course_name': 'MPK Agama',
      'total_score': 90.9,
      'total_percentage': 100.0
    },
    'recommended_score': 0,
    'max_possible_score': 90.9
  },
  'error': null
};
