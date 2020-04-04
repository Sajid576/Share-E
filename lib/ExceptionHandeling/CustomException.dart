import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/Authentication/LoginScreen.dart';
class CustomException{
  static void ExceptionHandeling(int value){
    if (value==1){
       AuxiliaryClass.showToast("All Field should be filled");
    }
  }
}