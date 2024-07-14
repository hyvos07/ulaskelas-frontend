part of '_datasources.dart';

class DummyData {
  /// Dummy Data (for development only!)
  // ignore: prefer_final_fields
  static Map<String, dynamic> _dummyData = {
    'data': <String, dynamic>{
      'all_semester_gpa': [
        <String, dynamic>{
          'given_semester': '1',
          'semester_gpa': 4.00,
          'total_sks': 18,
          'course_list': [
            {
              'id': '1',
              'course_name': 'DDP 1',
              'total_score': '85',
              'total_percentage': '100',
            },
            {
              'id': '2',
              'course_name': 'DDP 2',
              'total_score': '90',
              'total_percentage': '100',
            },
          ],
        },
        <String, dynamic>{
          'given_semester': 'sp_2023',
          'semester_gpa': 3.90,
          'total_sks': 22,
          'course_list': [],
        },
      ],
      'cumulative_gpa': <String, dynamic>{
        'user': 'daniel.liman',
        'cumulative_gpa': 3.95,
        'total_gpa': 158,
        'total_sks': 40,
      },
    },
    'error': null
  };

  static Map<String, dynamic> get getDummyData => _dummyData;
}
