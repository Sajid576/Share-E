import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/screens/LoginScreen.dart';
class CustomException{
  static void ExceptionHandeling(int value){
    if (value==1){
       AuxiliaryClass.showToast("All Field should be filled");
    }
  }
}