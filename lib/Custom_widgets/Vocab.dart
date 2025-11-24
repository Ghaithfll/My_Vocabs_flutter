import 'package:flutter/material.dart';
import 'package:my_vocabs/sharedVariables/shared_vars.dart';

class Vocab extends StatefulWidget {
  Vocab({super.key, required this.meaning, required this.word});
  String word;
  String meaning;
  @override
  State<Vocab> createState() => _VocabState();
}

class _VocabState extends State<Vocab> {
  TextEditingController Eng_cont = TextEditingController();

  TextEditingController Ar_cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Eng_cont.text = widget.word;
    Ar_cont.text = widget.meaning;
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          // was sizedbox
          color: Vocabs_Edit_mode ? Colors.amber : Colors.white,

          width: MediaQuery.sizeOf(context).width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Vocabs_Edit_mode == false
                  ? SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: Text(
                        widget.word,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ))
                  : SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: TextFormField(
                        controller: Eng_cont,
                        // decoration: InputDecoration(),
                      )),
              Vocabs_Edit_mode == false
                  ? SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: Text(widget.meaning,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)))
                  : SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: TextFormField(
                        onChanged: (value) {
                          // vocabmodel.word = Eng_cont.text
                          // and if u canceled the edit
                          // just restore the prev value
                          //(store the original val in a var before editing)
                        },
                        controller: Ar_cont,
                        // decoration: InputDecoration(border: InputBorder.none),
                      )),
            ],
          ),
        ));
  }
}
