import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_vocabs/Pages/All_Vocabs.dart';
import 'package:my_vocabs/models/category_model.dart';


class Category_Ui extends StatefulWidget {
   Category_Ui({super.key,required this.categ});
   CategoryModel categ;

  @override
  State<Category_Ui> createState() => _Category_UiState();
}

class _Category_UiState extends State<Category_Ui> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        
        onTap: () {
          Get.to(() => All_Vocabs(
                category: widget.categ,
                
              ));
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              widget.categ.categ_name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }
}