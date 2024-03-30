import 'package:my_todo_app/headers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(MyRoutes.homePage);
    });
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_screen/logo.png"),
            Text(
              "UpTodo",
              style: TextStyle(
                fontSize: textScaler.scale(35),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
