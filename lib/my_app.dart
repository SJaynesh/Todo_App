import 'package:my_todo_app/utills/controllers/todo_controller.dart';
import 'package:provider/provider.dart';

import 'headers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: MyRoutes.routes,
      ),
    );
  }
}
