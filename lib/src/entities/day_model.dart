import 'package:easy_localization/src/public_ext.dart';

class DayModel {
  DateTime title;
  String  date;

  DayModel(this.title, this.date);

  String getDayName(int weekDay){
    String day = '';
    switch (weekDay){
      case 1:{
        day = "Monday".tr();
        break;
      }
      case 2:{
        day = "Tuesday".tr();
        break;
      }
      case 3:{
        day = "Wednesday".tr();
        break;
      }
      case 4:{
        day = "Thursday".tr();
        break;
      }
      case 5:{
        day = "Friday".tr();
        break;
      }
      case 6:{
        day = "Saturday".tr();
        break;
      }
      case 7:{
        day = "Sunday".tr();
        break;
      }
    }
    return day;
  }

}