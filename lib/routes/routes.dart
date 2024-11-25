import 'package:apsglam/pages/camera.dart';
import 'package:apsglam/pages/edit.dart';
import 'package:apsglam/pages/home.dart';
import 'package:apsglam/pages/homeinicio.dart';
import 'package:apsglam/pages/inicio.dart';
import 'package:apsglam/pages/register.dart';
import 'package:apsglam/pages/settings.dart';
import 'package:get/get.dart';

class RoutesClass {
  static String home = "/";
  static String register = "/register";
  static String init = "/inicio";
  static String settings = "/settings";
  static String homeinit = "/home";
  static String camara = "/camara";
  static String edit = "/edit";

  static String getHomeRoute() => home;
  static String getRegisterRoute() => register;
  static String getInicioRoute() => init;
  static String getSettingsRoute() => settings;
  static String getCameraRoute() => camara;
  static String getHomeInitRoute() => homeinit;
  static String getEditRoute() => edit;



  static List<GetPage> routes = [
    GetPage(name: home, page: () => Home()),
    GetPage(name: register, page: ()=>Register()),
    GetPage(name: init, page: ()=> const Inicio()),
    GetPage(name: settings, page: ()=>const Settings()),
    GetPage(name: homeinit, page: ()=> const HomeInicio()),
    GetPage(name: camara, page: ()=> const CameraPage()),
    GetPage(name: edit, page: ()=> const Edit()),

  ];
}