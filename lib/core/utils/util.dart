String getFinalGrade(double score) {
  var grade = 'E';
  switch (score) {
    case >= 85:
      grade = 'A';
    case >= 80:
      grade = 'A-';
    case >= 75:
      grade = 'B+';
    case >= 70:
      grade = 'B';
    case >= 65:
      grade = 'B-';
    case >= 60:
      grade = 'C+';
    case >= 55:
      grade = 'C';
    case >= 40:
      grade = 'D';
  }

  return grade;
}

// Round to 2 decimal places and remove trailing zeros
String formatDouble(double value) {
  return value.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '');
}
