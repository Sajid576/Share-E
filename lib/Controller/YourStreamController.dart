import 'dart:async';
import 'package:rxdart/rxdart.dart';

class YourStreamController
{
  //it is initialized in GoogleMapView.init() constructor
  static StreamController<dynamic> HomeScreenController;


  //used to stream data in CartList
  static StreamController<dynamic> CartListstreamController = new BehaviorSubject();


}