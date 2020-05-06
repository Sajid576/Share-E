import 'dart:async';

class YourStreamController
{
  //it is initialized in GoogleMapView.init() constructor
  static StreamController<dynamic> HomeScreenController;


  //used to stream data in CartList
  static StreamController<dynamic> CartListstreamController = new StreamController<dynamic>();


}