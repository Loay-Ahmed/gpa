import 'dart:ffi';

enum Grade{
  Ap,
  A,
  Bp,
  B,
  Cp,
  C,
  Dp,
  D,
  F,
  notSelected
}

extension GradesExtension on Grade{
  String get name{
    switch(this){
      case Grade.Ap: return "A+";
      case Grade.A: return "A";
      case Grade.Bp: return "B+";
      case Grade.B: return "B";
      case Grade.Cp: return "C+";
      case Grade.C: return "C";
      case Grade.Dp: return "D+";
      case Grade.D: return "D";
      case Grade.F: return "F";
      case Grade.notSelected: return "";
    }
  }
  double get points{
    switch(this){
      case Grade.Ap: return 4;
      case Grade.A: return 3.7;
      case Grade.Bp: return 3.3;
      case Grade.B: return 3;
      case Grade.Cp: return 2.7;
      case Grade.C: return 2.4;
      case Grade.Dp: return 2.2;
      case Grade.D: return 2;
      case Grade.F: return 0;
      case Grade.notSelected: return 0;
    }
  }

}
Grade fromNameToGrade(String name){
  switch(name){
    case "A+": return Grade.Ap;
    case "A": return Grade.A;
    case "B+": return Grade.Bp;
    case "B": return Grade.B;
    case "C+": return Grade.Cp;
    case "C": return Grade.C;
    case "D+": return Grade.Dp;
    case "D": return Grade.D;
    case "F": return Grade.F;
  }
  return Grade.notSelected;
}