import 'package:apsglam/pages/home.dart';
import 'package:apsglam/pages/register.dart';
import 'package:get/get.dart';

class RoutesClass {
  static String home = "/";
  static String register = "/register";

  static String getHomeRoute() => home;
  static String getRegisterRoute() => register;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => Home()),
    GetPage(name: register, page: ()=>Register())
  ];
}