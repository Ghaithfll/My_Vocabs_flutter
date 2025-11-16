import 'package:flutter/material.dart';

class Vocab extends StatefulWidget {
  Vocab({super.key, required this.meaning, required this.word});
  String word;
  String meaning;
  @override
  State<Vocab> createState() => _VocabState();
}

class _VocabState extends State<Vocab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          //  color: Colors.amber,
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  child: Text(
                    widget.word,
                    style: const TextStyle(fontSize: 15),
                  )),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  child: Text(widget.meaning, style: const TextStyle(fontSize: 15))),
            ],
          ),
        ));
  }
}
