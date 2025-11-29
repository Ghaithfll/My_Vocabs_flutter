import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Categories_Page extends StatefulWidget {
  const Categories_Page({super.key});

  @override
  State<Categories_Page> createState() => _Categories_PageState();
}

class _Categories_PageState extends State<Categories_Page> {
  @override
  void initState() {
    // TODO: implement initState
     Read_Categories_List();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => All_Vocabs(
                                category: Categories[index],
                                cat_index: index,
                              ));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              Categories[index].categ_name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )));
              },
              itemCount: Categories.length,
            )),
          ],
        ));
  }
}
