import 'package:flutter/material.dart';
import 'package:my_vocabs/Custom_widgets/mark.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

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
    if (is_marks_read == false) {
      Read_Test_Mark_List();
      marks_cont.Read_Marks_From_marks_List();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => marks_cont.marks.isEmpty
        ? Center(
            child: Container(
            child: const Text("Your Test Results will Appear Here"),
          ))
        : WillPopScope(
            onWillPop: () async {
              if (marks_cont.marks_edit_mode.value == true) {
                setState(() {
                  marks_cont.Disable_Mark_Edit_Mode();
                });
                return false;
              }
              return true;
            },
            child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: marks_cont.marks.length,
                itemBuilder: (context, index) {
                  return Test_mark(
                    mark: Marks[index],
                  );
                })));
  }
}
