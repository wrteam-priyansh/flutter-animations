import 'package:get/route_manager.dart';
import 'package:getx_route/screens/assignmentScreen.dart';
import 'package:getx_route/screens/assignmentsScreen.dart';
import 'package:getx_route/screens/homeScreen.dart';
import 'package:getx_route/screens/splashScreen.dart';

class Routes {
  static String splashScreen = "/splash";
  static String homeScreen = "/";
  static String chatListScreen = "/chatList";
  static String chatScreen = "/chat";
  static String assignmentsScreen = "/assignments";
  static String assignmentScreen = "/assignment";

  static final List<GetPage> getPages = [
    GetPage(name: splashScreen, page: () => SplashScreen.getRouteInstance()),
    GetPage(name: homeScreen, page: () => HomeScreen.getRouteInstance()),
    GetPage(
        name: assignmentsScreen,
        page: () => AssignmentsScreen.getRouteInstance()),
    GetPage(
        name: assignmentScreen,
        page: () => AssignmentScreen.getRouteInstance()),
  ];
}
