import 'package:share_e/model/FirebaseShareServiceModel.dart';
import 'package:share_e/view/UserRecord/ShareServiceProductHelper.dart';

class ShareYourServiceController
{


  static requestSendDataToFirebase(String currentservice, String address, String time) {

    if (currentservice == "medicine share") {
      print("medicine share");
      FirebaseShareServiceModel().setMedicineServiceData(currentservice,address, time, ShareServiceProductHelper.medicineName.text.trim(),ShareServiceProductHelper.medicineDetails.text.trim(),ShareServiceProductHelper.medicineQuantity.text.trim(),ShareServiceProductHelper.medicineExpDate.text.trim(),ShareServiceProductHelper.medicinePrice.text.trim());
    } else if (currentservice == "vehicle share") {
      print("vehicle share");
      FirebaseShareServiceModel().setVehicleServiceData(currentservice, address, time, ShareServiceProductHelper.vehicleType.text.trim(), ShareServiceProductHelper.vehicleModel.text.trim(),ShareServiceProductHelper.vehiclePrice.text.trim());
    } else if (currentservice == "Food/Grocery/Fruit item Sharing") {
      print("Food/Grocery/Fruit item Sharing");
      FirebaseShareServiceModel().setFoodGroceryFruitServiceData(currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.foodfruitname.text.trim(),ShareServiceProductHelper.foodfruitquantity.text.trim(),ShareServiceProductHelper.foodfruitprice.text.trim());
    } else if (currentservice == "Book sharing") {
      print("Book sharing");
      FirebaseShareServiceModel().setBookServiceData(currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.bookname.text.trim(),ShareServiceProductHelper.writername.text.trim(),ShareServiceProductHelper.bookquantity.text.trim(),ShareServiceProductHelper.bookprice.text.trim());
    } else if (currentservice == "Parking sharing") {
      FirebaseShareServiceModel().setParkingServiceData(currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.buildingname.text.trim(),ShareServiceProductHelper.parkingprice.text.trim());
    } else if (currentservice == "House rent") {
      FirebaseShareServiceModel().setHouserentServiceData(currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.bedroomnumber.text.trim(),ShareServiceProductHelper.flatspace.text.trim(),ShareServiceProductHelper.washroomnumber.text.trim(),ShareServiceProductHelper.balconyquantity.text.trim(),ShareServiceProductHelper.houseprice.text.trim());
    } else if (currentservice == "Mechanic service") {
      FirebaseShareServiceModel().setMechanicServiceData(currentservice, address, time,ShareServiceProductHelper.character1,ShareServiceProductHelper.mechanicdetails.text.trim());
    }
  }
}