import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';

class CustomException{
  static void ExceptionHandeling(int value){
    if (value==1){
      AuxiliaryClass.showToast("All Field should be filled");
    }
    else if (value==2){
      AuxiliaryClass.showToast("Successfully done!");
    }
  }
}