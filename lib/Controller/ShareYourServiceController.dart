import 'package:share_e/model/FirebaseShareServiceModel.dart';
import 'package:share_e/view/UserRecord/ShareServiceProductHelper.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';
import 'package:share_e/ExceptionHandeling/CustomException.dart';

class ShareYourServiceController
{

  static requestSendDataToFirebase(String uid,String currentservice, String address, String time) {

    if (currentservice == ServiceTypeController.medicine) {
      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.medicineName.text.trim().isEmpty||ShareServiceProductHelper.medicineQuantity.text.trim().isEmpty||ShareServiceProductHelper.medicineExpDate.text.trim().isEmpty||ShareServiceProductHelper.medicinePrice.text.trim().isEmpty){
        CustomException.ExceptionHandeling(1);
      }
      else
        {
          print(ServiceTypeController.medicine);
          FirebaseShareServiceModel().setMedicineServiceData(uid,currentservice,address, time,
              ShareServiceProductHelper.medicineName.text.trim(),ShareServiceProductHelper.medicineDetails.text.trim(),
              ShareServiceProductHelper.medicineQuantity.text.trim(),ShareServiceProductHelper.medicineExpDate.text.trim(),
              ShareServiceProductHelper.medicinePrice.text.trim(),ShareServiceProductHelper.medicineDetails.text.trim());

        }
        }
    else if (currentservice ==ServiceTypeController.vehicle) {

      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty|| ShareServiceProductHelper.vehicleModel.text.trim().isEmpty||ShareServiceProductHelper.vehiclePrice.text.trim().isEmpty){
        CustomException.ExceptionHandeling(1);
      }
      else{
        print(ServiceTypeController.vehicle);
        FirebaseShareServiceModel().setVehicleServiceData(uid,currentservice, address, time,
            ShareServiceProductHelper.vehicleType.text.trim(), ShareServiceProductHelper.vehicleModel.text.trim(),
            ShareServiceProductHelper.vehiclePrice.text.trim(),ShareServiceProductHelper.vehicleDetails.text.trim());

      }
    }
    else if (currentservice == ServiceTypeController.food) {

      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty||ShareServiceProductHelper.foodfruitname.text.trim().isEmpty||ShareServiceProductHelper.foodfruitquantity.text.trim().isEmpty||ShareServiceProductHelper.foodfruitprice.text.trim().isEmpty){
        CustomException.ExceptionHandeling(1);
      }
      else
        {
          print(ServiceTypeController.food);
          FirebaseShareServiceModel().setFoodGroceryFruitServiceData(uid,currentservice, address, time,
              ShareServiceProductHelper.character1,ShareServiceProductHelper.foodfruitname.text.trim(),
              ShareServiceProductHelper.foodfruitquantity.text.trim(),
              ShareServiceProductHelper.foodfruitprice.text.trim(),ShareServiceProductHelper.foodfruitDetails.text.trim());

        }
    }
    else if (currentservice == ServiceTypeController.book) {
      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty||ShareServiceProductHelper.bookname.text.trim().isEmpty||ShareServiceProductHelper.writername.text.trim().isEmpty||ShareServiceProductHelper.bookquantity.text.trim().isEmpty||ShareServiceProductHelper.bookprice.text.trim().isEmpty){
          CustomException.ExceptionHandeling(1);
      }
      else
        {
          print(ServiceTypeController.book);
          FirebaseShareServiceModel().setBookServiceData(uid,currentservice, address, time,
              ShareServiceProductHelper.character1,ShareServiceProductHelper.bookname.text.trim(),
              ShareServiceProductHelper.writername.text.trim(),ShareServiceProductHelper.bookquantity.text.trim(),
              ShareServiceProductHelper.bookprice.text.trim(),ShareServiceProductHelper.bookDetails.text.trim());

        }
      }
    else if (currentservice == ServiceTypeController.parking) {
      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty||ShareServiceProductHelper.buildingname.text.trim().isEmpty||ShareServiceProductHelper.parkingprice.text.trim().isEmpty){
          CustomException.ExceptionHandeling(1);
      }
      else{
          FirebaseShareServiceModel().setParkingServiceData(uid,currentservice, address, time,
              ShareServiceProductHelper.character1,ShareServiceProductHelper.buildingname.text.trim(),
              ShareServiceProductHelper.parkingprice.text.trim(),ShareServiceProductHelper.parkingDetails.text.trim());

      }


     }
    else if (currentservice == ServiceTypeController.houseRent) {
      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty||ShareServiceProductHelper.bedroomnumber.text.trim().isEmpty||ShareServiceProductHelper.flatspace.text.trim().isEmpty||ShareServiceProductHelper.washroomnumber.text.trim().isEmpty||ShareServiceProductHelper.balconyquantity.text.trim().isEmpty||ShareServiceProductHelper.houseprice.text.trim().isEmpty){
          CustomException.ExceptionHandeling(1);
      }
      else
        {
          FirebaseShareServiceModel().setHouserentServiceData(uid,currentservice, address, time,
              ShareServiceProductHelper.character1,ShareServiceProductHelper.bedroomnumber.text.trim(),
              ShareServiceProductHelper.flatspace.text.trim(),ShareServiceProductHelper.washroomnumber.text.trim(),
              ShareServiceProductHelper.balconyquantity.text.trim(),ShareServiceProductHelper.houseprice.text.trim(),
              ShareServiceProductHelper.houseDetails.text.trim() );

        }
      }
    else if (currentservice == ServiceTypeController.mechanic) {
      if(address.isEmpty||time.isEmpty||ShareServiceProductHelper.character1.isEmpty){
        CustomException.ExceptionHandeling(1);
      }
      else
        {
          FirebaseShareServiceModel().setMechanicServiceData(uid,currentservice, address, time,
              ShareServiceProductHelper.character1,ShareServiceProductHelper.mechanicdetails.text.trim());

        }

      }

    else if (currentservice == ServiceTypeController.other) {
      if(address.isEmpty||time.isEmpty|| ShareServiceProductHelper.servicename.text.trim().isEmpty || ShareServiceProductHelper.servicetype.text.trim().isEmpty||ShareServiceProductHelper.serviceprice.text.trim().isEmpty){
        CustomException.ExceptionHandeling(1);
      }else{

        FirebaseShareServiceModel().setOtherServiceData(uid,currentservice, address, time,
            ShareServiceProductHelper.servicetype.text.trim(),ShareServiceProductHelper.servicename.text.trim(),
            ShareServiceProductHelper.servicedetails.text.trim(),ShareServiceProductHelper.serviceprice.text.trim());
      }
    }
  }
}