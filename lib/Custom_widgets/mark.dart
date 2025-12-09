import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/controllers/marks_cont.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class Test_mark extends StatefulWidget {
  Test_mark({
    super.key,
    required this.mark,
  });
  Tst_Mark_Modl mark;

  @override
  State<Test_mark> createState() => _Test_markState();
}

class _Test_markState extends State<Test_mark> {
  double formated_mark = 0;
  DateTime date = DateTime.now();
  bool mark_selected = false;
  final mark_cont = Get.put(Marks_controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formated_mark = widget.mark.score * 100;
   // date = widget.mark.date;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            if (mark_cont.marks_edit_mode.value == true) {
              setState(() {
                widget.mark.selected = !mark_selected;
                mark_selected = !mark_selected;
                print(mark_selected);
              });
            }
            setState(() {
              print("Refresh");
            });
          },
          onLongPress: () {
            setState(() {
              mark_cont.Enable_Mark_Edit_Mode();
            });
          },
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(221, 231, 221, 221),
                  borderRadius: BorderRadius.circular(20)),
              height: 100,
              // width: MediaQuery.sizeOf(context).width * 0.89,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          child: const Center(
                              child: CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.workspace_premium_outlined,
                              size: 40,
                              color: Color.fromARGB(146, 255, 85, 7),
                            ),
                          ))),
                      Container(
                          //  width: MediaQuery.sizeOf(context).width * 3,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.mark.Category_name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    DateFormat("dd MMM yyyy")
                                        .format(date), // DateTime.now formatted
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "${widget.mark.questions_cnt} questions",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                  Obx(() => Container(
                      width: MediaQuery.sizeOf(context).width * 0.23,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircularPercentIndicator(
                            radius: 30,
                            progressColor: Colors.blue,
                            animation: true,
                            center: mark_cont.marks_edit_mode.value == false
                                ? Text(
                                    "${formated_mark.toInt()}%",
                                    style: const TextStyle(fontSize: 12),
                                  )
                                : Checkbox(
                                    value: mark_selected,
                                    onChanged: (value) {
                                      setState(() {
                                        mark_selected = value!;
                                        widget.mark.selected = mark_selected;
                                      });
                                    },
                                  ),
                            percent: widget.mark.score,
                          ))))
                ],
              )),
        ));
  }
}
