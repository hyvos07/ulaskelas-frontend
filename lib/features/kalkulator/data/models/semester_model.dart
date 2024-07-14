class SemesterModel {
  String? givenSemester; // represents ID
  String? user;
  double? semesterGPA;
  int? totalSKS;

  SemesterModel(
      {
        this.givenSemester,
        this.user, // Will this ever be used..?
        this.semesterGPA,
        this.totalSKS,
      });

  SemesterModel.fromJson(Map<String, dynamic> json) {
    givenSemester = json['given_semester'];
    // user = json['user'];
    semesterGPA = json['semester_gpa'];
    totalSKS = json['total_sks'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['given_semester'] = givenSemester;
    // data['user'] = user;
    data['semester_gpa'] = semesterGPA;
    data['total_sks'] = totalSKS;
    
    return data;
  }
}
