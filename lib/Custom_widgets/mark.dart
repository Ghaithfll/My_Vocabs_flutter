import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class Test_mark extends StatefulWidget {
  Test_mark(
      {super.key,
      required this.mark,
      required this.questions_count,
      required this.test_category});
  int questions_count;
  String test_category;
  double mark;
  @override
  State<Test_mark> createState() => _Test_markState();
}

class _Test_markState extends State<Test_mark> {
  double formated_mark = 0;
  DateTime date = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formated_mark = widget.mark * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                                widget.test_category,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                DateFormat("dd MMM yyyy")
                                    .format(date), // DateTime.now formatted
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${widget.questions_count} questions",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ))),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularPercentIndicator(
                    radius: 30,
                    progressColor: Colors.blue,
                    animation: true,
                    center: Text(
                      "${formated_mark.toInt()}%",
                      style: const TextStyle(fontSize: 12),
                    ),
                    percent: widget.mark,
                  ))
            ],
          )),
    );
  }
}
