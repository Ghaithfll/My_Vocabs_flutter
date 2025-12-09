import 'package:get/get.dart';
import 'package:my_vocabs/main.dart';
import 'package:my_vocabs/models/tst_mark_modL.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Marks_controller extends GetxController {
  RxList<Tst_Mark_Modl> marks = <Tst_Mark_Modl>[].obs;
  RxBool marks_edit_mode = false.obs;

  void Enable_Mark_Edit_Mode() {
    marks_edit_mode.value = true;
  }

  void Disable_Mark_Edit_Mode() {
    marks_edit_mode.value = false;

    for (var mark in marks) {
      if (mark.selected) {
        mark.selected = false;
      }
    }
  }

  void Read_Marks_From_marks_List() {
    /* if u typed my_vocabs = box.get("my_vocabs_list")
    this wwill arise a type error cuz box.get returns List<dynamic>
    */
    marks.assignAll(
        Marks); // this assigns all the content of the stored list to our rxList, and in case the key is not existed, it assigns an empty list to prevent nulls

    print("\n\n DATA READ SUCCESSFULLY!!! \n");
  }

  void Add_test_mark_to_Controller(Tst_Mark_Modl mark) {
    marks.add(mark);
  }
}
