import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:math_expressions/math_expressions.dart';
import 'package:easy_localization/src/public_ext.dart';




class convertImageTo extends StatefulWidget {
  final File imageFile;
  final String text, imageIcon;
  final Color colorBar;

  const convertImageTo({Key? key,
    required this.imageFile,
    required this.text,
    required this.imageIcon,
    required this.colorBar})
      : super(key: key);

  @override
  State<convertImageTo> createState() => _convertImageToState();
}

class _convertImageToState extends State<convertImageTo> {
  String _extractText = '';
  bool flag = false;

  //File? _pickedImage;

  // final TextEditingController _ocrTextController =  TextEditingController();
  final TextEditingController _translatedController = TextEditingController();

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _controller = new TextEditingController();

    var width = MediaQuery
        .of(context)
        .size
        .width;
    var hight = MediaQuery
        .of(context)
        .size
        .height;
    var _languages = [
      {"text": 'Arabic', "abbr": "ar"},
      {"text": 'French', "abbr": "fr"},
      {"text": 'English', "abbr": "en"},
      {"text": 'Spanish', "abbr": "es"},
      {"text": 'Japanese', "abbr": "ja"},
      {"text": 'Hindi', "abbr": "hi"},
    ]
        .map((lang) => MultiSelectItem<String>(lang["abbr"]!, lang["text"]!))
        .toList();

    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_extractText);
    }

    Future _speakMultipleLang() async {
      //await flutterTts.setLanguage("ar-XA");
      await flutterTts.setLanguage("fr-CA");
      //await flutterTts.setLanguage("en-US");
      await flutterTts.setLanguage("es-ES");
      await flutterTts.setLanguage("ja-JP");
      //await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_extractText);
    }

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.colorBar,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(
              widget.imageIcon,
            ),
          ),
          title: Text(
            widget.text,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          actions: [

          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Image.file(
                      widget.imageFile,
                      width: width * 0.6,
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      flag = true;
                    });
                    String path = widget.imageFile.path
                        .toString();
                    //Image.file(widget.imageFile).image.toString();

                    final inputImage = InputImage.fromFile(widget.imageFile);
                    final textDetector = GoogleMlKit.vision.textDetector();
                    final RecognisedText recognisedText =
                    await textDetector.processImage(inputImage);
                    String text = recognisedText.text;


                    textDetector.close();
                    print(text);
                    _extractText = text;

                    setState(() {
                      flag = false;
                    });
                  },
                  child: Text('Convert To Text'.tr()),
                ),
                SizedBox(height: 20),
                flag
                    ? Center(child: CircularProgressIndicator())
                // : Center(
                //   child: Text(
                //     _extractText,
                //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                //   ),
                // ),

                    : Material(
                  elevation: 3.0,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      child: TextFormField(
                        // controller: _ocrTextController,
                        maxLines: 4,
                        cursorColor: Colors.black,
                        showCursor: true,
                        //_extractText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.fromLTRB(20, 5, 5, 5),
                          suffixIcon: IconButton(
                            onPressed: () => _speak(),
                            icon: Icon(
                              Icons.headset,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          // child: RaisedButton(
                          //   child: Icon(Icons.headset, color: Colors.black, size: 30,),
                          //     onPressed: () => _speak(),
                          // ),
                        ),
                        initialValue: _extractText,
                      ),

                      /*child: Center(
                          child: Text(
                            _extractText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),*/
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(flex: 2, child: Text("Translate".tr())),
                    //SizedBox(width:  width*0.1,),
                    Expanded(
                      flex: 3,
                      child: Material(
                          elevation: 2,
                          shadowColor: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                  color: Colors.white,
                                  child: MultiSelectDialogField(
                                    items: _languages,
                                    chipDisplay: MultiSelectChipDisplay(
                                      chipColor: Colors.black26,
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    //decoration: BoxDecoration(),
                                    title: Text("Language".tr()),


                                    selectedColor: Colors.black,
                                    onConfirm: (value) async {
                                      _translatedController.text = "";
                                      if (value.isEmpty) return;
                                      final String toLang = value
                                          .first as String;
                                      final translator = GoogleTranslator();
                                      final input = _extractText;
                                      String translatedText =
                                          (await translator.translate(input,
                                              to: toLang))
                                              .text;
                                      _translatedController.text =
                                          translatedText;
                                    },

                                  )))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 3.0,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      child: TextFormField(
                        controller: _translatedController,
                        maxLines: 4,
                        onTap: () {
                          print('g');
                        },
                        // textAlign: TextAlign.,
                        cursorColor: Colors.black,
                        showCursor: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () => _speakMultipleLang(),
                            icon: Icon(
                              Icons.headset,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
