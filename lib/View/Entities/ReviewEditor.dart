import 'package:flutter/material.dart';
// ignore_for_file: file_names

class ReviewEditor extends StatefulWidget {
  ReviewEditor({Key key}) : super(key: key);

  @override
  _ReviewEditorState createState() => _ReviewEditorState();
}

class _ReviewEditorState extends State<ReviewEditor> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF222222),
        body: CustomScrollView(slivers: [
          SliverAppBar(
              pinned: true,
              title: Text("Inserisci una Recensione"),
              backgroundColor: Color(0xFF333333),
              flexibleSpace:
                  FlexibleSpaceBar(background: Container(color: Colors.white))),
          SliverToBoxAdapter(child: Container())
        ]));
  }
}
