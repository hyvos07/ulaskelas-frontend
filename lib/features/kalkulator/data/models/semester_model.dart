class SemesterModel {
  String? givenSemester; // represents ID
  double? semesterMutu;
  double? semesterGPA;
  int? totalSKS;
  List<String>? courseList;

  SemesterModel(
      {
        this.givenSemester,
        this.totalSKS,
        this.semesterGPA,
        this.semesterMutu,
        this.courseList,
      });

  SemesterModel.fromJson(Map<String, dynamic> json) {
    givenSemester = json['given_semester'];
    totalSKS = json['total_sks'];
    semesterGPA = json['semester_gpa'];
    semesterMutu = json['semester_mutu'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['given_semester'] = givenSemester;
    data['total_sks'] = totalSKS;
    data['semester_gpa'] = semesterGPA;
    data['semester_mutu'] = semesterMutu;
    
    return data;
  }

  SemesterModel.forAutofill(
    String this.givenSemester, 
    List<String> this.courseList,
  );
}
