import 'dart:io';

import 'package:androidocr/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:translator/translator.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:easy_localization/src/public_ext.dart';

class convertMathTo extends StatefulWidget{

  final File imageFile;
  final String text , imageIcon;
  final Color colorBar;
  const convertMathTo({Key? key, required this.imageFile , required this.text , required this.imageIcon ,  required this.colorBar}) : super(key: key);

  @override
  State<convertMathTo> createState() => _convertMathToState();
}

class _convertMathToState extends State<convertMathTo> {
  String _extractText = '';
  bool flag = false;


  final TextEditingController _translatedController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var hight=MediaQuery.of(context).size.height;

    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_extractText);
    }

    Future _speakMultipleLang() async {
      //await flutterTts.setLanguage("ar-XA");
      //await flutterTts.setLanguage("fr-CA");
      //await flutterTts.setLanguage("en-US");
      //await flutterTts.setLanguage("es-ES");
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
            child: Image.asset(widget.imageIcon ,),
          ),
          title:
          Text(widget.text ,
            style: TextStyle(color: Colors.black, fontSize: 25),),
          actions: [

          ],

        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(child: Image.file(widget.imageFile , width: width * 0.6  ,)),
                SizedBox(
                  height: 10,

                ),
                Align(/*alignment: Alignment.topLeft,*/
                    child: Text('The Detuctet Equation'.tr() ,
                  style: TextStyle( fontSize: 23 , fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 10,

                ),


                ElevatedButton(onPressed: () async {
                    setState(() {
                    flag = true;

                    });
                String path = widget.imageFile.path
                .toString(); //Image.file(widget.imageFile).image.toString();

                final inputImage = InputImage.fromFile(widget.imageFile);
                final textDetector = GoogleMlKit.vision.textDetector();
                final RecognisedText recognisedText =
                await textDetector.processImage(inputImage);
                String text = recognisedText.text;

                  textDetector.close();
                  print(text);
                  _extractText = text;

                    /* Text equations */
                    try {
                      print(_extractText);
                      _extractText = _extractText.replaceAll("x", "*");
                      _extractText = _extractText.replaceAll("÷", "/");
                      Variable b = Variable('a');
                      Parser p = Parser();
                      Expression exp = p.parse(_extractText);
                      // Bind variables:
                      ContextModel cm = ContextModel();
                      cm.bindVariable(b, Number(2.0));
                      // cm.bindVariable(y, Number(Math.PI));

                      // Evaluate expression:
                      double eval = exp.evaluate(EvaluationType.REAL, cm);
                      _extractText = eval.toString();
                      print(eval); // = 1.0
                    } catch (ex){
                      print(ex);
                      _extractText = "No result".tr();
                    }
                    /* Text equations */

                  setState(() {
                    flag = false;
                  });
                  },

                  child: Text('Calculate'.tr()),
                ),
                SizedBox(height: 20),
                flag
                    ? Center(child: CircularProgressIndicator()):
                Material(
                  elevation:  3.0,
                  shadowColor: Colors.grey,

                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(

                      child: TextFormField(
                        maxLines: 4,

                        // textAlign: TextAlign.,
                        cursorColor: Colors.black,
                        showCursor: true,
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

                        ),

                        initialValue: _extractText,
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