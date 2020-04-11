import 'package:share_e/model/FirebaseShareServiceModel.dart';
import 'package:share_e/view/UserRecord/ShareServiceProductHelper.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';

class ShareYourServiceController
{

  static requestSendDataToFirebase(String uid,String currentservice, String address, String time) {

    if (currentservice == ServiceTypeController.medicine) {
      print(ServiceTypeController.medicine);
      FirebaseShareServiceModel().setMedicineServiceData(uid,currentservice,address, time, ShareServiceProductHelper.medicineName.text.trim(),ShareServiceProductHelper.medicineDetails.text.trim(),ShareServiceProductHelper.medicineQuantity.text.trim(),ShareServiceProductHelper.medicineExpDate.text.trim(),ShareServiceProductHelper.medicinePrice.text.trim());
    }
    else if (currentservice ==ServiceTypeController.vehicle) {
      print(ServiceTypeController.vehicle);
      FirebaseShareServiceModel().setVehicleServiceData(uid,currentservice, address, time, ShareServiceProductHelper.vehicleType.text.trim(), ShareServiceProductHelper.vehicleModel.text.trim(),ShareServiceProductHelper.vehiclePrice.text.trim());
    }
    else if (currentservice == ServiceTypeController.food) {
      print(ServiceTypeController.food);
      FirebaseShareServiceModel().setFoodGroceryFruitServiceData(uid,currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.foodfruitname.text.trim(),ShareServiceProductHelper.foodfruitquantity.text.trim(),ShareServiceProductHelper.foodfruitprice.text.trim());
    }
    else if (currentservice == ServiceTypeController.book) {
      print(ServiceTypeController.book);
      FirebaseShareServiceModel().setBookServiceData(uid,currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.bookname.text.trim(),ShareServiceProductHelper.writername.text.trim(),ShareServiceProductHelper.bookquantity.text.trim(),ShareServiceProductHelper.bookprice.text.trim());
    }
    else if (currentservice == ServiceTypeController.parking) {
      FirebaseShareServiceModel().setParkingServiceData(uid,currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.buildingname.text.trim(),ShareServiceProductHelper.parkingprice.text.trim());
    }
    else if (currentservice == ServiceTypeController.houseRent) {
      FirebaseShareServiceModel().setHouserentServiceData(uid,currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.bedroomnumber.text.trim(),ShareServiceProductHelper.flatspace.text.trim(),ShareServiceProductHelper.washroomnumber.text.trim(),ShareServiceProductHelper.balconyquantity.text.trim(),ShareServiceProductHelper.houseprice.text.trim());
    }
    else if (currentservice == ServiceTypeController.mechanic) {
      FirebaseShareServiceModel().setMechanicServiceData(uid,currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.mechanicdetails.text.trim());
    }
  }
}