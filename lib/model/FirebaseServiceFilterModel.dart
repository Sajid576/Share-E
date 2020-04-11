import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';

//Here all the functions of Service filtering will be implemented
class FirebaseServiceFilterModel
{


  searchByService(search) async
  {
    return Firestore.instance
        .collection('Shared_Services')
        .where('searchKey',
        isEqualTo: search.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  //this function will be called when a Service will be selected by user in Right navigation drawyer.
  //this function will return the filtered results to the UI
  filterByService(serviceType) async {
    var firestore = Firestore.instance; //giving a FireBase instance
    await firestore.collection("Shared_Services").where("active_state",isEqualTo: 1).where("service_product_type",isEqualTo: serviceType).getDocuments().then((query){
      print("*************DATA queried: "+query.documents.length.toString());
      GetAllSharedServiceController.setAllServiceData(query.documents);
     /* query.documents.forEach((doc) {

        Map<dynamic, dynamic> values = 	Map.from(doc.data);
        print('***********Data:' + values.toString() +'\n');
      });*/

    });
  }


}