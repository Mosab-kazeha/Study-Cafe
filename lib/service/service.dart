import 'package:dio/dio.dart';

abstract class Service {
  Dio dio = Dio();
  late Response response;

  String url = 'http://192.168.43.135:8022/api/v1';
  //!don't forget to change 192.168.1.8 to IPv4 adress the wifi

  //-------
  //-------
  //! Places
  String place = '/places/show/'; //? for the login => 4 is the id of place

  //! Reservation
  String addReservation = '/reservation/reservation/';
  //? the number 8 is Id of reservate
  String deletReservation = '/reservation/cancelReservation/';
  //? 5 is for the id reservation
  String showReservation = '/reservation/getAll';

  //!Tables
  String showTables = '/tables/findByRoomId/'; //? 2 is for Room id
  String addTable = '/tables/newTable'; //?we need to pass the Room id in model

  //!Rooms

  String showAllRoom = '/rooms/1/AllRooms';
  //* number 1 for what? */ number 1 is id the place
  String addRoom = '/rooms/1/newRoom';
  //?we need to pass the place id in model
}
