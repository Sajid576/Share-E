import 'package:cloud_firestore/cloud_firestore.dart';

//Here all the store functions of Share Service will be implemented
class FirebaseShareServiceModel
{
  Future setMedicineServiceData(String currentService,String address,String time,String medicineName,String medicineDetails,String medicineQuantity,String medicineExpDate,String medicinePrice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_product_name']=medicineName;
    map['service_product_details']=medicineDetails;
    map['service_product_quantity']=medicineQuantity;
    map['service_product_expdate']=medicineExpDate;
    map['price']=medicinePrice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }

  Future setVehicleServiceData(String currentService,String address,String time,String vehicleType,String vehicleModel,String vehiclePrice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_product_name']=vehicleType;
    map['service_product_model']=vehicleModel;
    map['price']=vehiclePrice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }

  Future setFoodGroceryFruitServiceData(String currentService,String address,String time,String _character1,String foodfruitname,String foodfuitquantity,String foodfuitPrice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_product']=_character1;
    map['service_product_name']=foodfruitname;
    map['service_product_quantity']=foodfuitquantity;
    map['price']=foodfuitPrice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }
  Future setBookServiceData(String currentService,String address,String time,String _character1,String bookname,String writername,String bookquantity,String bookprice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_product']=_character1;
    map['service_product_name']=bookname;
    map['writer_name']=writername;
    map['service_product_quantity']=bookquantity;
    map['price']=bookprice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }

  Future setParkingServiceData(String currentService,String address,String time,String _character1,String buildingname,String parkingprice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_space_for']=_character1;
    map['service_building_name']=buildingname;

    map['price']=parkingprice;
    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }

  Future setHouserentServiceData(String currentService,String address,String time,String _character1,String bedroomnumber,String flatspace,String washroomnumber,String balconyquantity,String _houseprice)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
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
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }

  Future setMechanicServiceData(String currentService,String address,String time,String _character1,String mechanicdetails)async{
    final  userinfo = Firestore.instance.collection('Shared_Services');
    DocumentReference docReference = userinfo.document();
    Map<String, dynamic>map=new Map();
    map['service_product_type']=currentService;
    map['area']=address;
    map['service_product_time']=time;
    map['service_provided_for']=_character1;
    map['service_details']=mechanicdetails;

    docReference.setData(map).then((doc) {
      print('hop ${docReference.documentID}');
      userinfo.document(docReference.documentID).setData({
        'service_id': docReference.documentID,
      },merge: true);

    }).catchError((error) {
      print(error);
    });
  }
}