import 'package:my_todo_app/headers.dart';
import 'package:my_todo_app/utills/helpers/db_helper.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.filter_list,
          color: Color(0xffFFFFFF),
        ),
        centerTitle: true,
        title: Text(
          "TODO",
          style: TextStyle(
            fontSize: textScaler.scale(25),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: w * 0.06,
            backgroundImage: const NetworkImage(
                "https://avatars.githubusercontent.com/u/115562979?v=4"),
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
        backgroundColor: const Color(0xff000000),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/home_page/todo.png",
              height: h * 0.3,
            ),
            Text(
              "What do you want to do today?",
              style: TextStyle(
                fontSize: textScaler.scale(20),
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
            Text(
              "Tap + to add your tasks",
              style: TextStyle(
                fontSize: textScaler.scale(18),
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
            const Spacer(
              flex: 4,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myDailyTasks(context, textScaler, h);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff8687E7),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xff000000),
    );
  }

  Future<dynamic> myDailyTasks(
      BuildContext context, TextScaler textScaler, double h) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "My TODO",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: textScaler.scale(25),
            ),
          ),
          content: SizedBox(
            height: h * 0.05,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: taskController,
                validator: (val) =>
                    val!.isEmpty ? "Enter your daily task" : null,
                decoration: const InputDecoration(
                  hintText: "Enter any task..",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton.outlined(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  String title = taskController.text;
                  int res = await DBHelper.dbHelper.insertMyTask(title: title);

                  if (res >= 1) {
                    SnackBar snackBar = SnackBar(
                      content: Text("$res data insert Successfully 😁"),
                      backgroundColor: Colors.green,
                      margin: const EdgeInsets.all(8),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                    taskController.clear();
                  }
                }
              },
              icon: const Icon(Icons.send),
            )
          ],
        );
      },
    );
  }
}
