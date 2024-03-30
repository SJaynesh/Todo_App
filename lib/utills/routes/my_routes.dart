import 'package:my_todo_app/headers.dart';

class MyRoutes {
  static String splashScreen = "/";
  static String homePage = "home_page";

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    homePage: (context) => HomePage()
  };
}
