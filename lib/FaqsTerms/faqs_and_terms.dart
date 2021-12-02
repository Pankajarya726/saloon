import 'package:flutter/material.dart';
import 'package:html/parser.dart';
// import 'package:flutter_html/flutter_html.dart';

class FaqsAndTerms extends StatefulWidget {
  @override
  _FaqsAndTermsState createState() => _FaqsAndTermsState();
}

class _FaqsAndTermsState extends State<FaqsAndTerms> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String Data =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas gravida ultricies massa, quis dapibus ex scelerisque suscipit. Aliquam elit enim, maximus in ante sit amet, tempor finibus arcu. Curabitur ac diam ante. Morbi sit amet pellentesque erat, at maximus odio. Etiam condimentum mi libero, et venenatis nunc semper eget. Proin in rhoncus magna. Praesent pharetra nibh sed nisi suscipit fermentum. Suspendisse id nunc ut mi vestibulum suscipit. Nam consectetur quis ante sit amet aliquam. Donec ac mauris a arcu aliquam pretium ut vitae dolor. Sed laoreet porttitor sem ut congue. Vestibulum erat urna, convallis ac tristique et, aliquam a lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam tincidunt vitae massa in rutrum. Donec non felis tincidunt, aliquet diam vitae, rutrum sem. Sed vulputate volutpat nisi, eleifend ultricies mauris facilisis sit amet.";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(child: Text(parse(Data).body.text)
          // Html(
          //   data:Data,
          //   onLinkTap: (url) {
          //     print("Opening $url...");
          //   },
          // ),
          ),
    );
  }
}
