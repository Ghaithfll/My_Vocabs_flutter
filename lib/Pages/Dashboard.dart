import 'package:flutter/material.dart';
import 'package:my_vocabs/Custom_widgets/mark.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

//*** *************** this page may become ur score  ****************************** ***/

class _DashboardState extends State<Dashboard> {
  final marks_cont = Get.put(Marks_controller());

  @override
  void initState() {
    // TODO: implement initState
    // read marks
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => marks_cont.marks.isEmpty
          ? Center(
              child: Container(
              child: const Text("Your Test Results will Appear Here"),
            ))
          : ListView.builder(
              itemCount: marks_cont.marks.length,
              itemBuilder: (context, index) => Test_mark(
                  mark: marks_cont.marks[index].score,
                  questions_count: marks_cont.marks[index].questions_cnt,
                  test_category: marks_cont.marks[index].Category),
            ),
    );
  }
}
