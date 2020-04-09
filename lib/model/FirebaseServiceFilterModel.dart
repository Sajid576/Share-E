import 'package:cloud_firestore/cloud_firestore.dart';

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

  filterByService(serviceName)
  {

  }
}