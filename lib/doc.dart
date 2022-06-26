import 'dart:io';
import 'package:androidocr/constant.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class convertDocTo extends StatefulWidget {
  final String text, imageIcon;
  final Color colorBar;
  final String typeFile;

  final String pathFile;
  final String nameFile;

  const convertDocTo(
      {Key? key,
      required this.text,
      required this.imageIcon,
      required this.colorBar,
      required this.pathFile,
      required this.nameFile,
      required this.typeFile})
      : super(key: key);

  @override
  State<convertDocTo> createState() => _convertDocToState();
}

class _convertDocToState extends State<convertDocTo> {
  String _extractText = '';
  bool flag = false;
  bool isSearching = false;
  bool reasult = false;
  String highlight_value = '';
  var num1;

  String variable = '';

  final FlutterTts flutterTts = FlutterTts();
  final _highlightcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_extractText);
    }

    Future<List<int>> _readDocumentData(String name) async {
      final ByteData data = await rootBundle.load('assets/$name');
      return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: widget.colorBar,
        leading: !isSearching
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  widget.imageIcon,
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
              ),
        title: !isSearching
            ? Text(
                widget.text,
                style: TextStyle(color: Colors.black, fontSize: 25),
              )
            : Container(
                child: TextField(
                  controller: _highlightcontroller,
                  autocorrect: true,
                  onChanged: (text) {
                    this.setState(() {
                      reasult = _extractText.contains(text);
                      highlight_value = text;
                    });
                    print(highlight_value);

                    print("out put is ##################");
                    print(reasult);

                    if (reasult == true) {
                      int len = highlight_value.length;
                      print(len);

                      int index_of = _extractText.indexOf(highlight_value);
                      print(index_of);

                      variable =
                          _extractText.substring(index_of, index_of + len);
                      print(variable);

                    }
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black),
                    hintText: "Search word Here",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  onPressed: _highlightcontroller.clear,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  child: PDF().fromPath(widget.pathFile),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    flag = true;
                  });

                  PdfDocument document = PdfDocument(
                      inputBytes:
                          await _readDocumentData(widget.nameFile.toString()));
                  PdfTextExtractor extractor = PdfTextExtractor(document);
                  String text = extractor.extractText();
                  _extractText = text;
                  print(_extractText);
                  setState(() {
                    flag = false;
                  });
                },
                child: Text(
                  'Extract Text'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
              ),

              ElevatedButton.icon(
                onPressed: () => _speak(),
                icon: Icon(
                  Icons.headphones,
                  color: Colors.white,
                  size: 25.0,
                ),
                label: Text('Listen'.tr()),
              ),

              SizedBox(height: 20),
              flag
                  ? Center(child: CircularProgressIndicator())
                  : Material(
                      elevation: 3.0,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(15),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),

                          child: Container(

                            color: Colors.white,
                            child: EasyRichText(
                                _extractText,
                                defaultStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: variable,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ),

                      ),
                    ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
