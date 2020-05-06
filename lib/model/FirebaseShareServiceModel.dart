import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/ExceptionHandeling/CustomException.dart';

//Here all the store functions of Share Service will be implemented
class FirebaseShareServiceModel
{
  Future setMedicineServiceData(String uid,String currentService,String address,String time,String medicineName,String medicineDetails,String medicineQuantity,String medicineExpDate,String medicinePrice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();

    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_product_name']=medicineName;
    map['service_product_details']=medicineDetails;
    map['service_product_quantity']=medicineQuantity;
    map['service_product_expdate']=medicineExpDate;
    map['price']=medicinePrice;
    docReference.setData(map).then((doc) {

      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  Future setVehicleServiceData(String uid,String currentService,String address,String time,String vehicleType,String vehicleModel,String vehiclePrice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_product_name']=vehicleType;
    map['service_product_model']=vehicleModel;
    map['price']=vehiclePrice;
    docReference.setData(map).then((doc) {

      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  Future setFoodGroceryFruitServiceData(String uid,String currentService,String address,String time,String _character1,String foodfruitname,String foodfuitquantity,String foodfuitPrice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();

    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_product']=_character1;
    map['service_product_name']=foodfruitname;
    map['service_product_quantity']=foodfuitquantity;
    map['price']=foodfuitPrice;
    docReference.setData(map).then((doc) {

      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }
  Future setBookServiceData(String uid,String currentService,String address,String time,String _character1,String bookname,String writername,String bookquantity,String bookprice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();

    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_product']=_character1;
    map['service_product_name']=bookname;
    map['writer_name']=writername;
    map['service_product_quantity']=bookquantity;
    map['price']=bookprice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  Future setParkingServiceData(String uid,String currentService,String address,String time,String _character1,String buildingname,String parkingprice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_space_for']=_character1;
    map['service_building_name']=buildingname;

    map['price']=parkingprice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  Future setHouserentServiceData(String uid,String currentService,String address,String time,String _character1,String bedroomnumber,String flatspace,String washroomnumber,String balconyquantity,String _houseprice,String details)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['active']=1;
    map['uid']=uid;
    map['details']=details;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_provided_for']=_character1;
    map['service_bedroom_number']=bedroomnumber;
    map['flat_space']=flatspace;
    map['washroom_number']=washroomnumber;
    map['belcony_number']=balconyquantity;
    map['rent']=_houseprice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  Future setMechanicServiceData(String uid,String currentService,String address,String time,String _character1,String mechanicdetails)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['active']=1;
    map['uid']=uid;
    map['details']=mechanicdetails;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_provided_for']=_character1;


    docReference.setData(map).then((doc) {

      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }

  setOtherServiceData(String uid,String currentService,String address,String time,String servicetype,String servicename,String servicedetails,String serviceprice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();

    map['active']=1;
    map['uid']=uid;
    map['details']=servicedetails;
    map['service_product_type']=currentService;
    map['area']=address;
    map['available_time']=time;
    map['service_provided_type']=servicetype;
    map['service_product_name']=servicename;
    map['price']=serviceprice;
    docReference.setData(map).then((doc) {

      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true).then((value) => CustomException.ExceptionHandeling(2));

    }).catchError((error) {
      print(error);
    });
  }




}